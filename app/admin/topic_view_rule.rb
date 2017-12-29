ActiveAdmin.register TopicViewRule do
  menu priority: 22, parent: '模版管理'
  permit_params :day, :interval, :min_increase, :max_increase, :hot

  index do
    column :day
    column(:interval) { |i| best_in_place i, :interval, as: 'input', place_holder: '点我添加', url: [:admin, i] }
    column(:min_increase) { |i| best_in_place i, :min_increase, as: 'input', place_holder: '点我添加', url: [:admin, i] }
    column(:max_increase) { |i| best_in_place i, :max_increase, as: 'input', place_holder: '点我添加', url: [:admin, i] }
    column :hot
    actions
  end
end
