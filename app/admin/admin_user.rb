ActiveAdmin.register AdminUser do
  menu priority: 1, parent: '用户管理', label: '管理员列表'
  actions :all, except: [:show]

  permit_params :email, :password, :password_confirmation
  config.filters = false

  index do
    column 'Id', :id
    column :email
    column :sign_in_count
    column :last_sign_in_at
    column :last_sign_in_ip
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
