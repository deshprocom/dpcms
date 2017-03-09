ActiveAdmin.register PurchaseOrder do
  menu label: '订单列表', priority: 3
  permit_params :price, :email, :address, :consignee, :mobile, :status
  actions :all, :except => [:new]
  ORDER_STATUS = PurchaseOrder.statuses.keys

  scope :all, default: 'true'
  scope :unpaid
  scope :paid
  scope :completed
  scope :canceled

  filter :order_number
  filter :created_at
  filter :status, as: :select, collection: ORDER_STATUS.collect { |key| [I18n.t(key), key] }

  index do
    id_column
    column :order_number
    column '用户id', :user_id do |order|
      order.user.user_uuid
    end
    column '真实姓名', :real_name do |order|
      order.user.user_extra.real_name
    end
    column '实名状态', :user_status do |order|
      order.user.user_extra.status.eql?('passed') ? '已实名' : '未实名'
    end
    column :original_price
    column :price
    column :status do |order|
      I18n.t(order.status)
    end
    actions name:'操作', defaults: false do |order|
      item '编辑', edit_admin_purchase_order_path(order), class: 'member_link'
      item '取消', cancel_admin_purchase_order_path(order), data: { confirm: "确定取消吗？" }, method: :post
    end
  end

  member_action :cancel, method: :post do
    resource.canceled!
    redirect_to action: 'index'
  end

  member_action :change_status, method: :post do
    if params[:order_price].blank?
      return render 'change_status_failed'
    end
    resource.update(price: params[:order_price].to_i)
  end

  form partial: 'edit_order'
end
