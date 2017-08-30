ActiveAdmin.register SmsLog do
  config.batch_actions = false
  config.clear_action_items!

  filter :mobile
  filter :content
  filter :fee
  filter :send_time
  filter :status

  index do
    id_column
    column :mobile
    column :content
    column :error_msg
    column :fee
    column :send_time
    column :arrival_time
    column :status
  end
end
