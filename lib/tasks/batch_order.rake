namespace :batch_order do
  desc '将24小时前创建并且未支付的订单取消'
  task cancel_unpaid_one_day_ago: :environment do
    Rails.application.eager_load!
    puts 'cancel_unpaid_one_day_ago start'
    orders = PurchaseOrder.unpaid_one_day_ago
    orders.each do |order|
      Services::Orders::CancelOrderService.call(order)
    end
    puts 'cancel_unpaid_one_day_ago end'
  end

  desc '将已发货15天，但未确认收货的订单修改为 已完成'
  task complete_delivered_15_days: :environment do
    Rails.application.eager_load!
    puts 'complete_delivered_15_days start'
    orders = PurchaseOrder.delivered_15_days
    orders.each(&:completed!)
    puts 'complete_delivered_15_days end'
  end
end