# coding: utf-8

Given(/^已使用 '([^']*)'登录$/) do |value|
  user = FactoryGirl.create(:admin_user, email: value)
  login_as(user)
end

Given(/^访问 '([^']*)'$/) do |location|
  path = send(PATH_MAPPING[location])
  visit path
  page.current_path
  expect(page).to have_current_path(path)
end

Given(/^应到达 '([^']*)'$/) do |location|
  path = send(PATH_MAPPING[location])
  page.current_path
  expect(page).to have_current_path(path)
end

When(/^在 '([^']*)' 填入 '([^']*)'$/) do |input_txt, value|
  input_id = INPUT_MAPPING[input_txt]
  fill_in(input_id, with: value)
end

When(/^在 '([^']*)' 上传图片$/) do |input_txt|
  input_id = INPUT_MAPPING[input_txt]
  attach_file(input_id, Rails.root.join('spec/factories/foo.png'))
end

Given(/^点击链接 '([^']*)'$/) do |link|
  click_link(link)
end

Given(/^点击按钮 '([^']*)'$/) do |button|
  click_button(button)
end

Given(/^对话框中点击 '([^']*)'$/) do |text|
  accept_confirm(text)
end

Given(/^确定alert$/) do
  accept_alert
end

Given(/^等待 ([^']*) 秒$/) do |second|
  sleep(second.to_i)
end

Given(/^'([^']*)' 应看到 '([^']*)'$/) do |element, value|
  element_id = ELEMENT_MAPPING[element]
  find_by_id(element_id).should have_content(value)
end

Given(/^在'([^']*)' 的第一个下拉框选择 '([^']*)'$/) do |id, text|
  first(:select, id).find(:option, text).select_option
end
