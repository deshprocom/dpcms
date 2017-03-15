# source 'https://rubygems.org'
source 'https://gems.ruby-china.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.0'
gem 'uglifier', '>= 1.3.0'
gem 'dotenv-rails'

# view 相关
gem 'haml'
gem 'jbuilder', '~> 2.5'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'

# activeadmin 相关
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
gem 'devise'
gem 'rails-i18n'
gem 'redcarpet'

# 上传组件
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano3-puma'
  gem 'rubocop', require: false
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false
  gem 'selenium-webdriver'
  gem 'capybara-console'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
