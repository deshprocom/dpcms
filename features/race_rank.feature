Feature: 排行榜
  可添加编辑删除排名

  Background:
    Given 已使用 'admin@deshpro.com'登录

  Scenario: 进入赛事排行榜，创建排名
    Given 访问赛事详情页 创建数据
    And 创建牌手数据
    And 点击链接 '赛事排行榜'
    And 点击链接 '新增排名'
    When 点击按钮 '新增排名'
    And 表单应提醒不能为空 'new_race_rank'
    And 点击链接 '搜索牌手'
    And 点击按钮 '搜索'
    And 等待 0.1 秒
    And 点击第一个按钮 '选择'
    And 在 '名次' 填入 '1'
    And 在 '赢入奖金' 填入 '89000'
    And 在 '得分' 填入 '200'
    And 点击按钮 '新增排名'
    Then 应得到成功提示 '新建排名成功'

  Scenario: 进入赛事排行榜，修改排名
    Given 访问赛事排行榜 创建数据
    And 点击链接 '编辑'
    When 在 '得分' 填入 '200'
    And 点击按钮 '更新排名'
    Then 应得到成功提示 '更新排名成功'

