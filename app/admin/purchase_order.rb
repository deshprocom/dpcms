ActiveAdmin.register PurchaseOrder do

  menu label: '订单列表', priority: 3
  permit_params :price, :email, :address, :consignee, :mobile, :status

  ORDER_STATUS = %w(unpaid paid completed canceled).freeze

  scope :all, default: 'true'
  scope :unpaid
  scope :paid
  scope :completed
  scope :canceled

  index do
    id_column
    column :order_number
    column :user_id do |order|
      order.user.user_uuid
    end
    column :real_name do |order|
      order.user.user_extra.real_name
    end
    column :user_status do |order|
      order.user.user_extra.status
    end
    column :original_price
    column :price
    column :status
    actions
  end

end
