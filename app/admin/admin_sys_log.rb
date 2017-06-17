ActiveAdmin.register AdminSysLog do
  menu label: '日志管理', priority: 20
  actions :index

  index do
    column :id
    column :operation_type
    column :operation_id do |operation|
      operation.operation_id
    end
    column :action
    column :admin_user_id
    column :mark
    column :updated_at
  end
end
