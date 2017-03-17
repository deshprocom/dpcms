# coding: utf-8

Given(/^调用api 应无法获取该赛事详情$/) do
  race = Race.last
  result = DpApiRemote.get("u/:user_id/races/#{race.id}")
  puts result.parsed_body
  expect(result.parsed_body['code']).to eq 1100006
end

Given(/^调用api 应成功获取该赛事详情/) do
  race = Race.last
  result = DpApiRemote.get("u/:user_id/races/#{race.id}").parsed_body
  puts result['msg']
  expect(result['code']).to   eq(0)
  data = result['data']
  expect(data['race_id']).to  eq(race.id)
  expect(data['name']).to     eq(race.name)
  expect(data['seq_id']).to   eq(race.seq_id)
  expect(data['logo']).to     eq("#{ENV['PHOTO_DOMAIN']}#{race.logo.url(:preview)}")
end
