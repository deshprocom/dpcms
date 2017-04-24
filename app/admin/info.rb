ActiveAdmin.register Info do
  SOURCE_TYPE = %w(source author).freeze
  INFO_TYPES = InfoType.all.collect{ |type| [type.name, type.id] }
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
    actions name: '操作'
  end

  sidebar :'资讯数目', only: :index do
    "资讯共：#{Info.count}条"
  end

  form partial: 'edit_info'
end
