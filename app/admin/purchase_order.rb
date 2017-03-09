ActiveAdmin.register PurchaseOrder do
  # include Admin::PurchaseOrderHelper

  menu label: '订单列表', priority: 3
  permit_params :price, :email, :address, :consignee, :mobile, :status
  actions :all, :except => [:new]

  scope :all, default: 'true'
  scope :unpaid
  scope :paid
  scope :completed
  scope :canceled

  filter :order_number
  filter :created_at
  filter :status, as: :select, collection: Admin::PurchaseOrderHelper.order_status_collection

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
      Admin::PurchaseOrderHelper.order_status[:"#{order.status}"]
    end
    actions name:'操作', defaults: false do |resource|
      link_to('编辑', edit_admin_purchase_order_path(resource)) + ' | ' +
      link_to('取消', admin_purchase_order_path(resource), data: { confirm: "确定取消吗？" }, method: :delete)
    end
  end

  controller do
    def destroy
      @purchase_order = PurchaseOrder.find(params[:id])
      unless @purchase_order.update(status: 'canceled')
        flash[:alert] = "订单不可取消"
      end
      redirect_to action: 'index'
    end
  end

  form partial: 'edit_order'
end
