# rubocop:disable Metrics/BlockLength
ActiveAdmin.register AdminRole do
  config.filters = false
  menu priority: 1, parent: '用户管理'
  permit_params :name, permissions: []
  form do |f|
    f.inputs do
      f.input :name, label: '角色名称'
      f.input :permissions,
              as: :check_boxes,
              collection: CmsAuthorization.permissions_with_trans
    end
    f.actions
  end

  index do
    id_column
    column(:name)
    column(:permissions, &:permissions_text)
    actions
  end

  show do
    attributes_table do
      row(:id)
      row(:name)
      row(:permissions, &:permissions_text)
    end
  end

  controller do
    before_action :process_params, only: [:create, :update]

    def process_params
      params[:admin_role][:permissions].reject!(&:empty?)
    end
  end
end
