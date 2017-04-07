# coding: utf-8
Given(/^访问牌手管理页 创建数据$/) do
  FactoryGirl.create(:player)
  visit admin_players_path
end