FactoryGirl.define do
  factory :race_desc do
    description '### **2017APT启航站**

2017APT启航站将于2017年1月11日至1月19日在马尼拉云顶世界举行。主赛Day1A将于1月14日中午1点举行，买入费用为1650美元（约11440RMB）。

#### 主赛再次参赛规则：

当日第7轮赛事之前可再次参赛.
已晋级选手可在主赛第1轮B组再次参赛.
以多组筹码晋级第2轮的选手只能留用较多一组的筹码

#### 以下为赛程表：
![enter description here](http://img.dzpk.com/allimg/140604/4454-140604112S4638.jpg?width=561&height=571)

 加 标的赛事均为双日赛，八强决战桌将在次日下午1点开始
如果双日赛八强在首日晚十点前产生，比赛将转为单日赛
所有参赛费及入场费均以美元(USD)结算
赛事奖池的3%将用作人工费，资格赛及慈善赛除外
主赛事及豪客赛最低人工费为USD100，其他赛事最低人工费为USD10

#### 报名截止

 主赛及其他赛事（豪客赛，资格赛除外）报名将在第7轮开始前截止.
豪客赛将在第10轮开始前截止
资格赛及重购或加购赛将于首轮休息后截止
赛程或将更新，恕不另行通知.
参赛者需年满21岁'
    association :race
  end
end
