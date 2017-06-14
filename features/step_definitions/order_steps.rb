# coding: utf-8

Given(/^创建用户订单$/) do
  step '前端用户已登录'
  user = @login_result['data']
  race = FactoryGirl.create(:whole_race, published: true)
  ticket = race.tickets.first
  race.publish!
  race.update!(ticket_status: 'selling')
  result = DpApiRemote.post "races/#{race.id}/tickets/#{ticket.id}/orders",
                            { ticket_type: 'e_ticket', email: user['email'] },
                            user['access_token']
  p result.parsed_body
  expect(result.parsed_body['code']).to eq(0)
end
