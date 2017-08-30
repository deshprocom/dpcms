ActiveAdmin.register WeixinUser do
  config.batch_actions = false
  config.clear_action_items!

  filter :user_id, as: :string
  filter :open_id
  filter :nick_name
  filter :province
  filter :city
  filter :created_at

  index do
    id_column
    column :open_id
    column '微信头像', :image do |info|
      link_to image_tag(info.head_img, height: '100px'), info.head_img, target: '_blank'
    end
    column :user_id
    column :nick_name
    column :sex do |info|
      info.sex.eql?(1) ? '男' : '女'
    end
    column :province
    column :city
    column :created_at
  end
end
