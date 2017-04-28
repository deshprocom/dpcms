Feature: 资讯管理
  登录成功后，可进行资讯管理

  Background:
    Given 已使用 'admin@deshpro.com'登录

  Scenario: 资讯管理-新建资讯
    Given 访问 '新建资讯页'
    When 在 '资讯图片' 上传图片
    And 在 '资讯名称' 填入 '澳洲赛'
    And 点击按钮或链接 '新建资讯'
    Then 应该成功创建一条资讯

  Scenario: 资讯管理-资讯列表
    Given 访问资讯管理页 创建资讯为未发布状态
    Then 应该能找到 '作者,Timmy' 这些信息

  Scenario: 资讯管理-发布资讯
    Given 访问资讯管理页 创建资讯为未发布状态
    When 点击按钮或链接 '发布'
    And 确定alert
    Then 应得到成功提示 '发布成功'

  Scenario: 资讯管理-非置顶状态下取消发布
    Given 访问资讯管理页 创建资讯为发布状态
    When 点击按钮或链接 '取消发布'
    And 确定alert
    Then 应得到成功提示 '取消发布成功'

  Scenario: 资讯管理-置顶状态下取消发布
    Given 访问资讯管理页 创建资讯为发布已置顶状态
    When 点击按钮或链接 '取消发布'
    And 确定alert
    Then 资讯状态应该变成未发布未置顶

  Scenario: 资讯管理-未发布未置顶的资讯置顶
    Given 访问资讯管理页 创建资讯为未发布状态
    When 点击按钮或链接 '置顶'
    And 确定alert
    Then 资讯状态应该变成已发布已置顶

  Scenario: 资讯管理-已发布未置顶的资讯置顶
    Given 访问资讯管理页 创建资讯为发布状态
    When 点击按钮或链接 '置顶'
    And 确定alert
    Then 资讯状态应该变成已发布已置顶

  Scenario: 资讯管理-删除资讯
    Given 访问资讯管理页 创建资讯为发布状态
    When 点击按钮或链接 '删除'
    And 确定alert
    Then 数据库资讯数目为0