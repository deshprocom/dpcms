Feature: 订单首页
  登录成功后，应能进入订单首页管理

  Background:
    Given 已使用 'admin@deshpro.com'登录
    And 创建用户订单

  Scenario: 点击订单列表
    When 访问 '订单列表页'
    Then 应该能找到 'uuid_12345,王石,审核中,待付款' 这些信息

  Scenario: 取消订单
    When 访问 '订单列表页'
    When 点击链接 '取消'
    And 对话框中点击 '确定'
    And 等待 2 秒
    Then 应该能找到 '已取消' 这些信息

  Scenario: 修改金额
    When 访问 '订单列表页'
    And 点击链接 '编辑'
    And 点击按钮 '修改金额'
    And 在 '实付金额' 填入 '1024'
    And 等待 2 秒
    And 点击按钮 '保存'
    And 对话框中点击 '确定'
    And 确定alert
    And 等待 3 秒
    Then 应该能找到 '1024' 这些信息

  Scenario: 审核不通过
    When 访问 '订单列表页'
    When 点击链接 '编辑'
    And 点击按钮或链接 '审核不通过'
    And 对话框中点击 '确定'
    And 确定alert
    And 等待 2 秒
    Then 应该能找到 '未通过' 这些信息

  Scenario: 审核通过
    When 访问 '订单列表页'
    When 点击链接 '编辑'
    And 点击按钮或链接 '审核通过'
    And 对话框中点击 '确定'
    And 确定alert
    And 等待 2 秒
    Then 应该能找到 '已实名' 这些信息