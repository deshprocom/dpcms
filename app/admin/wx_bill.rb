ActiveAdmin.register WxBill do
  menu parent: '账单管理'
  config.batch_actions = false

  filter :open_id
  filter :bank_type
  filter :total_fee
  filter :fee_type
  filter :out_trade_no
  filter :trade_type
  filter :time_end
  filter :transaction_id

  index do
    id_column
    column :out_trade_no
    column :open_id, sortable: false
    column :total_fee do |bill|
      bill.total_fee / 100
    end
    column :fee_type, sortable: false
    column :time_end
    column :trade_type, sortable: false
    column :result_code, sortable: false
    column :return_code, sortable: false
    column :transaction_id
  end
end
