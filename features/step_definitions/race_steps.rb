# coding: utf-8
Given(/^访问赛事详情页 创建数据$/) do
  race = FactoryGirl.create(:whole_race, published: true)
  visit admin_race_path(race.id)
end

Given(/^访问赛事列表页 创建数据$/) do
  FactoryGirl.create(:whole_race, published: true)
  visit admin_races_path
end

Given(/^调用api 应无法获取该赛事详情$/) do
  race = Race.last
  result = DpApiRemote.get("u/0/races/#{race.id}")
  puts result.parsed_body
  expect(result.parsed_body['code']).to eq 1100006
end

Given(/^调用api 应成功获取该赛事详情/) do
  race = Race.first
  result = DpApiRemote.get("u/0/races/#{race.id}").parsed_body
  puts result['msg']
  expect(result['code']).to   eq(0)
  data = result['data']
  expect(data['race_id']).to  eq(race.id)
  expect(data['name']).to     eq(race.name)
  expect(data['seq_id']).to   eq(race.seq_id)
  expect(data['status']).to   eq(race.status)
  expect(data['logo']).to     eq(race.preview_logo)
  expect(data['big_logo']).to eq(race.big_logo)
end

