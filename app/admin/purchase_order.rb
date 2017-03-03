ActiveAdmin.register PurchaseOrder do

  menu label: '订单列表', priority: 3
  permit_params :price, :email, :address, :consignee, :mobile, :status

  scope :all, default: 'true'
  scope :unpaid
  scope :paid
  scope :completed
  scope :canceled

end
