# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Info do
  menu priority: 3, parent: '资讯管理', label: '资讯列表'
  SOURCE_TYPE = %w(source author).collect { |d| [I18n.t("info.#{d}"), d] }

  permit_params :title, :date, :source_type, :source, :image, :image_thumb, :top,
                :published, :description, :info_type_id, info_en_attributes: [:id, :title, :source, :description]

  @types = InfoType.all.collect do |type|
    type_name = type.published ? type.name + ' [已发布]' : type.name
    [type_name, type.id]
  end

  filter :title
  filter :source_type, as: :select, collection: SOURCE_TYPE
  filter :source
  filter :date
  filter :published
  filter :top
  filter :info_type_id, as: :select, collection: @types

  index title: '资讯管理' do
    column '资讯图片', :image do |info|
      link_to image_tag(info.image_thumb), info.image_thumb, target: '_blank'
    end
    column :title
    column :source_type do |info|
      info.source_type.eql?('source') ? '来源' : '作者'
    end
    column :source
    column :date
    column :info_type_id
    column :top
    column :published
    actions name: '操作', class: 'info_actions' do |resource|
      if resource.published
        msg = resource.top ? '取消发布之前会先取消置顶该资讯，继续吗？' : '确定取消吗？'
        item '取消发布', unpublish_admin_info_path(resource),
             data: { confirm: msg }, method: :post
      else
        item '发布', publish_admin_info_path(resource),
             data: { confirm: '确定发布吗？' }, method: :post
      end

      if resource.top
        item '取消置顶', untop_admin_info_path(resource),
             data: { confirm: '确定取消置顶吗？' }, method: :post
      else
        # 如果该资讯下已有其它已发布的是置顶状态，那么会先取消其它的，然后将这条资讯置顶
        resource_type = resource.info_type || resource.build_info_type
        message = if resource_type.infos.published.topped.present?
                    resource.published ? '置顶之前会先取消该类别下其它资讯置顶，确定吗？' : '置顶之前会先取消该类别下其它资讯置顶、并发布该条资讯，继续吗？'
                  else
                    resource.published ? '确定置顶吗？' : '置顶之前会先发布该资讯，继续吗？'
                  end
        item '置顶', top_admin_info_path(resource),
             data: { confirm: message }, method: :post
      end
    end
  end

  # 逻辑说明：
  # 1，一个类别下的资讯只能有一条资讯是置顶状态
  # 2，取消发布之前会先将该资讯取消置顶
  # 3，置顶之前会先对该资讯进行发布
  # 4，置顶之前会先取消该类别下其它资讯类别置顶
  member_action :publish, method: :post do
    resource.publish!
    redirect_back fallback_location: admin_infos_url, notice: '发布成功'
  end

  member_action :unpublish, method: :post do
    resource.unpublish!
    resource.untop! if resource.top
    redirect_back fallback_location: admin_infos_url, notice: '取消发布成功'
  end

  member_action :top, method: :post do
    resource_type = resource.info_type || resource.build_info_type
    list = resource_type.infos.published.topped
    # 将其它该类别下已置顶的全部先取消置顶
    list.present? && list.map(&:untop!)
    resource.top!
    resource.publish! unless resource.published
    redirect_back fallback_location: admin_infos_url, notice: '置顶成功'
  end

  member_action :untop, method: :post do
    resource.untop!
    redirect_back fallback_location: admin_infos_url, notice: '取消置顶成功'
  end

  sidebar :'资讯数目', only: :index do
    "资讯共：#{Info.count}条"
  end

  form partial: 'edit_info'

  controller do
    def create
      info = Info.new(update_params)
      if info.save
        # 添加标签
        tag_ids = params[:info][:tag_ids]
        tag_ids&.map { |tag_id| RaceTagMap.create(data: info, race_tag_id: tag_id) }
        redirect_to admin_infos_url, notice: '添加成功'
      else
        redirect_to admin_infos_url, notice: '添加失败'
      end
    end

    def update
      unless resource.info_type_id.eql? update_params['info_type_id'].to_i
        # 说明更换了类别 那么不管 反正你要换类别，你先取消置顶再说
        resource.untop!
      end
      # 如果取消发布，也会先取消置顶
      resource.untop! if update_params['published'].to_i.zero?

      # 保存数据
      flash[:notice] = if resource.update!(update_params)
                         '资讯更新成功'
                       else
                         '资讯更新失败'
                       end
      # 替换所有标签
      tag_ids = params[:info][:tag_ids]
      # 首先删除该资讯对应的所有标签
      resource.race_tag_maps.map(&:destroy)
      tag_ids&.map { |tag_id| RaceTagMap.create(data: resource, race_tag_id: tag_id) }
      redirect_to admin_infos_url
    end

    private

    def update_params
      params.require(:info).permit(:image,
                                   :title,
                                   :date,
                                   :source_type,
                                   :source,
                                   :info_type_id,
                                   :published,
                                   :top,
                                   :image_thumb,
                                   :description,
                                   info_en_attributes: [:id, :title, :source, :description])
    end
  end
end
