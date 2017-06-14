jpush_vars = %w(JPUSH_APP_KEY JPUSH_MASTER_SECRET JPUSH_APNS_PRODUCTION)
ucloud_vars = %w(UCLOUD_BUCKET UCLOUD_BUCKET_HOST UCLOUD_CDN_HOST)
cache_vars = %w(CACHE_DATABASE_TYPE CACHE_DATABASE_PATH)
path_vars = %w(CMS_PHOTO_PATH DPAPI_PHOTO_PATH)
current_vars = %w(CURRENT_PROJECT_ENV CURRENT_PROJECT)
env_vars = current_vars + jpush_vars + ucloud_vars + cache_vars + path_vars
env_vars.each do |var|
  if ENV[var].nil?
    raise "环境变量 #{var} 必须存在"
  end
end