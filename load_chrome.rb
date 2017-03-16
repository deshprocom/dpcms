require 'capybara/dsl'
include Capybara::DSL
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new app, browser: :chrome, driver_path: '/Users/breeze/Downloads/chromedriver'
end
Capybara.default_driver = :selenium_chrome