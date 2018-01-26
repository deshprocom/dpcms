ActiveAdmin.register PokerCoin do
  menu priority: 25
  config.clear_action_items!

  filter :typeable_type
  filter :typeable_id
  filter :user_nick_name, as: :string
  filter :user_mobile, as: :string
  filter :memo
  filter :number
  filter :created_at

  index do
    render 'index', context: self
  end
end
