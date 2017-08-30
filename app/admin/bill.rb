ActiveAdmin.register Bill do
  menu parent: '账单管理'
  config.batch_actions = false

  filter :order_number
  filter :amount
  filter :pay_time
  filter :trade_number

  index do
    id_column
    column :order_number
    column :amount
    column :pay_time
    column :trade_status
    column :trade_msg
    column :trade_number
  end
end
