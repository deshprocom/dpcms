require 'carrierwave-ucloud/lib/carrierwave-ucloud'
CarrierWave.configure do |config|
  # config.storage = :upyun
  # # Do not remove previously file after new file uploaded
  # config.remove_previously_stored_files_after_update = false
  # config.upyun_username = 12
  # config.upyun_password = 12
  # config.upyun_bucket = 12
  # config.upyun_bucket_host = 12

  config.storage = :ucloud
  config.public_key = 'wtzkb/5oUfZoeDgrz5r0fc85/krg7UkS8OLLwSVPuvtxd0RX9Vm/+w=='
  config.private_key = '6a0d76a6d5f7be5248ed4745626aa04fe82d4ef2'
  config.ucloud_bucket = 'deshpro-ci2'
  config.ucloud_bucket_host = 'http://deshpro-ci2.cn-gd.ufileos.com'
  config.ucloud_cdn_host = 'http://deshpro-ci2.ufile.ucloud.com.cn'
end
