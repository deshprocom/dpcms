ActiveAdmin.register ProductOrder, namespace: :shop do
  config.breadcrumb = false
  PRODUCT_ORDER_STATUS = ProductOrder.statuses.keys

  scope :all, default: 'true'
  scope :unpaid
  scope :paid
  scope :delivered
  scope :returning
  scope :returned
  scope :completed
  scope :canceled

  filter :user_user_uuid, as: :string
  filter :user_email_or_user_mobile, as: :string
  filter :order_number
  filter :created_at

  member_action :cancel_order, method: [:get, :post] do
    return render :cancel unless request.post?
    reason = params[:cancel_reason]
    resource.cancel_order reason
    redirect_back fallback_location: shop_product_orders_url
  end

  index download_links: false do
    render 'index'
  end
end
