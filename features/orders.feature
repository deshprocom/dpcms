Feature: 订单首页
  登录成功后，应能进入订单首页管理

  Background:
    Given 已使用 'admin@deshpro.com'登录
    And 创建用户订单

  Scenario: 点击订单列表
    When 访问 '订单列表页'
    Then 应该能找到 'uuid_12345,王石,未实名,待付款' 这些信息

  Scenario: 取消订单
    When 访问 '订单列表页'
    When 点击链接 '取消'
    And 我在Alert中点击 "确定"