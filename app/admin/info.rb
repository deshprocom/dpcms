ActiveAdmin.register Info do
  menu label: '资讯管理', priority: 5

  filter :title
  filter :date
  filter :published

  index title: '资讯列表' do
    column '资讯图片', :image do |info|
      link_to image_tag('http://localhost/example', height: 60)
    end
    column :title
    column :source_type do |info|
      info.source_type.eql?('source') ? '来源' : '作者'
    end
    column :source
    column :date
    column :info_type_id do |info|
      info.info_type
    end
    column :top
    column :published
    actions name: '操作'
  end

  sidebar :'资讯数目', only: :index do
    "资讯共：#{Info.count}条"
  end
end
