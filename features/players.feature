Feature: 牌手管理
  登录成功后，可进行牌手管理

  Background:
    Given 已使用 'admin@deshpro.com'登录

  Scenario: 牌手管理-牌手总数量
    When 访问牌手管理页 创建数据
    Then 应该能找到 '牌手总数量：1名' 这些信息

  Scenario: 牌手管理-删除
    When 访问牌手管理页 创建数据
    And 点击按钮或链接 '删除'
    Then 应该能找到 '牌手总数量：0名' 这些信息