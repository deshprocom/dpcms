ActiveAdmin.register AdminUser do
  menu label: '管理员列表', priority: 1

  permit_params :email, :password, :password_confirmation
  config.filters = false

  index do
    column "Id", :id
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
