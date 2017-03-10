# rubocop:disable Metrics/BlockLength
ActiveAdmin.register PurchaseOrder do
  menu label: '订单列表', priority: 3
  permit_params :price, :email, :address, :consignee, :mobile, :status
  actions :all, except: [:new]
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
      order.user.user_extra || order.user.build_user_extra
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
    actions name: '操作', defaults: false do |order|
      item '编辑', edit_admin_purchase_order_path(order), class: 'member_link'
      item '取消', cancel_admin_purchase_order_path(order), data: { confirm: '确定取消吗？' }, method: :post
    end
  end

  member_action :cancel, method: :post do
    resource.canceled!
    redirect_to action: 'index'
  end

  member_action :change_status, method: :post do
    return render 'common/params_format_error' if params[:order_price].blank?
    resource.update(price: params[:order_price].to_i)
    render 'common/update_success'
  end

  member_action :change_e_ticket_address, method: :post do
    email = params[:email].strip
    unless email.present? && UserValidator.email_valid?(email)
      return render 'common/email_format_error'
    end
    resource.update!(email: email)
    render 'common/update_success'
  end

  member_action :change_entity_ticket_address, method: :post do
    consignee = params[:consignee].strip
    mobile = params[:mobile].strip
    address = params[:address].strip
    unless consignee.present? && mobile.present? && address.present?
      return render 'common/params_format_error'
    end
    return render 'common/mobile_format_error' unless UserValidator.mobile_valid?(mobile)
    resource.update!(consignee: consignee, mobile: mobile, address: address)
    render 'common/update_success'
  end

  form partial: 'edit_order'
end
