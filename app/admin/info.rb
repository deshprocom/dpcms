ActiveAdmin.register Info do
  SOURCE_TYPE = %w(source author).freeze
  INFO_TYPES = InfoType.where(published: true).collect { |type| [type.name, type.id] }
  menu label: '资讯管理', priority: 5

  permit_params :title, :date, :source_type, :source, :image, :image_thumb, :top,
                :published, :description, :info_type_id

  filter :title
  filter :date
  filter :published
  filter :info_type_id, as: :select, collection: INFO_TYPES

  index title: '资讯管理' do
    # column '资讯图片', :image do |info|
    #   link_to image_tag('http://localhost/example', height: 60)
    # end
    column :title
    column :source_type do |info|
      info.source_type.eql?('source') ? '来源' : '作者'
    end
    column :source
    column :date
    column :info_type_id
    column :top
    column :published
    actions name: '操作', class: 'info_actions' do |type|
      if type.published
        item '取消发布', unpublish_admin_info_path(type),
             data: { confirm: '确定取消吗？' }, method: :post
      else
        item '发布', publish_admin_info_path(type),
             data: { confirm: '确定发布吗？' }, method: :post
      end
      if type.top
        item '取消置顶', untop_admin_info_path(type),
             data: { confirm: '确定取消置顶吗？' }, method: :post
      else
        item '置顶', top_admin_info_path(type),
             data: { confirm: '确定置顶吗？' }, method: :post
      end
    end
  end

  member_action :publish, method: :post do
    resource.publish!
    redirect_back fallback_location: admin_infos_url, notice: '发布成功'
  end

  member_action :unpublish, method: :post do
    resource.unpublish!
    redirect_back fallback_location: admin_infos_url, notice: '取消发布成功'
  end

  member_action :top, method: :post do
    resource.top!
    redirect_back fallback_location: admin_infos_url, notice: '发布成功'
  end

  member_action :untop, method: :post do
    resource.untop!
    redirect_back fallback_location: admin_infos_url, notice: '取消发布成功'
  end

  sidebar :'资讯数目', only: :index do
    "资讯共：#{Info.count}条"
  end

  form partial: 'edit_info'
end
