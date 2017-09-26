ActiveAdmin.register TemplateType do
  menu priority: 21, parent: '日志管理'
  filter :name
  permit_params :name
end
