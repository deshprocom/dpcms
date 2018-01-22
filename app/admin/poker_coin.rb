ActiveAdmin.register PokerCoin do
  menu priority: 25
  config.clear_action_items!

  index do
    render 'index', context: self
  end
end
