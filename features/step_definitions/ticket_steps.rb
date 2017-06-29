# coding: utf-8
Given(/^调用api 应成功获取该票务详情/) do
  step '前端用户已登录'
  user = @login_result['data']
  race   = Race.first
  params = {token: user['access_token']}
  result = DpApiRemote.get("races/#{race.id}/tickets", params).parsed_body
  puts result['msg']
  expect(result['code']).to   eq(0)
  race_hash = result['data']['race']
  tickets = result['data']['tickets']
  expect(race_hash['race_id']).to  eq(race.id)
  expect(race_hash['name']).to     eq(race.name)
  expect(tickets.size).to eq(2)
  ticket = race.tickets[1]
  expect(tickets[1]['title']).to eq(ticket.title)
  expect(tickets[1]['title']).to eq('飞机票 + 017APT启航站主票')
  expect(tickets[1]['price']).to eq(ticket.price)
end
