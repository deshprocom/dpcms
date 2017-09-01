ActiveAdmin.register AdminSysLog do
  menu label: '日志管理', priority: 20
  actions :index

  index do
    column :id
    column :operation_type
    column :operation_id, &:operation_id
    column :action
    column :admin_user_id do |log|
      log.admin_user.email
    end
    column :mark
    column :updated_at
  end
end
