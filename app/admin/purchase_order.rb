# rubocop:disable Metrics/BlockLength
# rubocop:disable Style/GlobalVars
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

  filter :user_user_uuid, as: :string
  filter :user_email_or_user_mobile, as: :string
  filter :order_number
  filter :created_at
  filter :status, as: :select, collection: ORDER_STATUS.collect { |key| [I18n.t("order.#{key}"), key] }

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
      I18n.t("user_extra.#{order.user.user_extra.status}")
    end
    column :original_price
    column :price
    column :status do |order|
      I18n.t("order.#{order.status}")
    end
    actions name: '操作', defaults: false do |order|
      item '编辑', edit_admin_purchase_order_path(order), class: 'member_link'
      item '取消', cancel_admin_purchase_order_path(order, change_status: 'canceled'),
           data: { confirm: '确定取消吗？' }, method: :post
    end
  end

  member_action :cancel, method: :post do
    change_status = params[:change_status]
    old_status = resource.status
    mobile = resource.mobile || resource.user.mobile
    template = if change_status.eql?('canceled')
                 $settings['cancel_order_template']
               elsif change_status.eql?('paid')
                 $settings['payment_template']
               elsif change_status.eql?('completed')
                 $settings['shipping_template']
               end
    content = format(template, resource.order_number)
    resource.update!(status: change_status) unless old_status.eql? change_status
    # 手机号不为空 并且 状态不相等的时候 才会去发短信
    unless old_status.eql?(change_status) || mobile.blank? || Rails.env.test?
      SmsJob.send_mobile(change_status, mobile, content)
    end
    if change_status.eql? 'canceled'
      redirect_to action: 'index'
    else
      render 'cancel_order'
    end
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
