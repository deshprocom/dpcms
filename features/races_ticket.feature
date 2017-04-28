Feature: 票务管理
  登录后，可进行票务管理

  Background:
    Given 已使用 'admin@deshpro.com'登录

  Scenario: 进入票务管理列表
    Given 访问 '赛事列表页'
    And 点击链接 '票务管理'
    Then 应到达 '票务管理列表页'

  Scenario: 创建有售票的的赛事
    Given 访问 '新建赛事页'
    When 在 '赛事标题' 填入 '2017传奇扑克超高额豪客赛'
    And 在 '奖池' 填入 '888888'
    And 在 '比赛地点' 填入 '中国澳门'
    And 在 '赛事图片' 上传图片
    And 点击按钮 '新建赛事'
    And 前往 '票务管理列表页'
    Then 列表中应只有 '1' 条数据

  Scenario: 创建不售票的的赛事
    Given 访问 '新建赛事页'
    When 在 '赛事标题' 填入 '2017传奇扑克超高额豪客赛'
    And 在 '奖池' 填入 '888888'
    And 在 '比赛地点' 填入 '中国澳门'
    And 在 '赛事图片' 上传图片
    And 不勾选 '是否有售票功能'
    And 点击按钮 '新建赛事'
    And 前往 '票务管理列表页'
    Then 应有提示暂无相应内容

  Scenario: 票务管理列表中更新状态
    Given 访问赛事列表页 创建数据
    And 前往 '票务管理列表页'
    Then 调用api 应成功获取该赛事详情
    When 在'ticket_status' 的第一个下拉框选择 '售票结束'
    And 确定alert
    Then 调用api 应成功获取该赛事详情

  Scenario: 取消售票成功
    Given 访问赛事列表页 创建数据
    And 前往 '票务管理列表页'
    And 点击链接 '取消售票'
    When 对话框中点击 '确定'
    Then 调用api 应取消售票成功

  Scenario: 取消售票失败
    Given 访问赛事列表页 创建数据
    And 前往 '票务管理列表页'
    When 在'ticket_status' 的第一个下拉框选择 '售票结束'
    And 确定alert
    And 点击链接 '取消售票'
    When 对话框中点击 '确定'
    Then 应得到错误提示 '非未售票状态下，不允许取消售票'

  Scenario: 票务管理详情页新增电子票
    Given 访问赛事详情页 创建数据
    When 点击链接 '票务管理'
    And 新增电子票 '3' 张
    Then 电子票票数应变成 '53' 张

  Scenario: 票务管理详情页减少电子票
    Given 访问赛事详情页 创建数据
    When 点击链接 '票务管理'
    And 减少电子票 '10' 张
    Then 电子票票数应变成 '40' 张

  Scenario: 票务管理详情页减少电子票失败
    Given 访问赛事详情页 创建数据
    When 点击链接 '票务管理'
    And 减少电子票 '60' 张
    Then 应得到错误提示 '减去的票数不允许大于剩余的票数'

  Scenario: 票务管理详情页新增实体票
    Given 访问赛事详情页 创建数据
    When 点击链接 '票务管理'
    And 新增实体票 '3' 张
    Then 实体票票数应变成 '3' 张

  Scenario: 票务管理详情页减少实体票
    Given 访问赛事详情页 创建数据
    When 点击链接 '票务管理'
    And 新增实体票 '3' 张
    Then 实体票票数应变成 '3' 张
    And 减少实体票 '2' 张
    Then 实体票票数应变成 '1' 张

  Scenario: 票务管理详情页减少实体票失败
    Given 访问赛事详情页 创建数据
    When 点击链接 '票务管理'
    And 新增实体票 '3' 张
    Then 实体票票数应变成 '3' 张
    And 减少实体票 '12' 张
    Then 应得到错误提示 '减去的票数不允许大于剩余的票数'
