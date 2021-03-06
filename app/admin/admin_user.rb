ActiveAdmin.register AdminUser do
  menu label: '管理员列表', priority: 1
  actions :all, except: [:show]

  permit_params :email, :password, :password_confirmation
  config.filters = false

  index do
    column 'Id', :id
    column :email
    column :sign_in_count
    column :last_sign_in_at
    column :last_sign_in_ip
    column :created_at do |obj|
      DateTime.current.parse(obj.created_at.to_s).strftime('%Y年%m月%d日').to_s
    end
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
