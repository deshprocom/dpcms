# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :output, './log/cron_log.log'
# set :environment, 'development'

every :hour do
  rake 'batch_order:cancel_unpaid_one_day_ago'
end

every :hour, at: '2:30am' do
  rake 'batch_order:complete_delivered_15_days'
end