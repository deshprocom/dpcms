# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Video do
  menu priority: 3, parent: '资讯管理', label: '视频列表'
  permit_params :name, :video_link, :title_desc, :cover_link, :video_duration, :top, :published,
                :description, :video_type_id, video_en_attributes: [:name, :title_desc, :description]

  @types = VideoType.all.collect do |type|
    type_name = type.published ? type.name + ' [已发布]' : type.name
    [type_name, type.id]
  end

  filter :name
  filter :published
  filter :top
  filter :video_type_id, as: :select, collection: @types

  index title: '视频管理' do
    column :name, sortable: false
    column :title_desc, sortable: false
    column '封面图片', :cover_link do |video|
      link_to image_tag(video.image_thumb), video.image_thumb, target: '_blank'
    end
    column '视频播放', :video_link do |video|
      video_tag(video.video_link, controls: true, autobuffer: true, height: 200) if video.video_link.present?
    end
    column :video_duration
    column :video_type_id, sortable: false
    column :top
    column :published
    actions name: '操作', class: 'video_actions' do |resource|
      if resource.published
        msg = resource.top ? '取消发布之前会先取消置顶该视频，继续吗？' : '确定取消吗？'
        item '取消发布', unpublish_admin_video_path(resource),
             data: { confirm: msg }, method: :post
      else
        item '发布', publish_admin_video_path(resource),
             data: { confirm: '确定发布吗？' }, method: :post
      end

      if resource.top
        item '取消置顶', untop_admin_video_path(resource),
             data: { confirm: '确定取消置顶吗？' }, method: :post
      else
        resource_type = resource.video_type || resource.build_video_type
        message = if resource_type.videos.published.topped.present?
                    resource.published ? '置顶之前会先取消该类别下其它视频置顶，确定吗？' : '置顶之前会先取消该类别下其它视频置顶、并发布该视频，继续吗？'
                  else
                    resource.published ? '确定置顶吗？' : '置顶之前会先发布该视频，继续吗？'
                  end
        item '置顶', top_admin_video_path(resource),
             data: { confirm: message }, method: :post
      end
    end
  end

  member_action :publish, method: :post do
    resource.publish!
    redirect_back fallback_location: admin_videos_url, notice: '发布成功'
  end

  member_action :unpublish, method: :post do
    resource.unpublish!
    resource.untop! if resource.top
    redirect_back fallback_location: admin_videos_url, notice: '取消发布成功'
  end

  member_action :top, method: :post do
    resource_type = resource.video_type || resource.build_video_type
    list = resource_type.videos.published.topped
    list.present? && list.map(&:untop!)
    resource.top!
    resource.publish! unless resource.published
    redirect_back fallback_location: admin_videos_url, notice: '置顶成功'
  end

  member_action :untop, method: :post do
    resource.untop!
    redirect_back fallback_location: admin_videos_url, notice: '取消置顶成功'
  end

  sidebar :'资讯数目', only: :index do
    "资讯共：#{Video.count}条"
  end

  action_item :add, only: :index do
    link_to '视频类别', admin_video_types_path
  end

  form partial: 'edit_info'

  controller do
    def update
      unless resource.video_type_id.eql? update_params['video_type_id'].to_i
        # 说明更换了类别 那么不管 反正你要换类别，你先取消置顶再说
        resource.untop!
      end
      # 如果取消发布，也会先取消置顶
      resource.untop! if update_params['published'].to_i.zero?

      # 保存数据
      flash[:notice] = if resource.update!(update_params)
                         '视频更新成功'
                       else
                         '视频更新失败'
                       end
      redirect_to admin_videos_url
    end

    private

    def update_params
      params.require(:video).permit(:name,
                                    :video_type_id,
                                    :video_link,
                                    :cover_link,
                                    :title_desc,
                                    :video_duration,
                                    :published,
                                    :top,
                                    :description,
                                    video_en_attributes: [:id, :name, :title_desc, :description])
    end
  end
end
