env_vars = %w(CMS_PHOTO_PATH CACHE_DATABASE_TYPE CACHE_DATABASE_PATH CURRENT_PROJECT)
env_vars.each do |var|
  if ENV[var].nil?
    raise "环境变量 #{var} 必须存在"
  end
end