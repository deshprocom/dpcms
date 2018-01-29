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

  member_action :coin, method: [:get, :post] do
    @max_coin = PokerCoin.total_coin_of_the_type(resource.typeable, resource.user)
    return render 'coin' unless request.post?
    return render 'params_blank' if params[:number].to_f.zero? || params[:memo].blank?
    return render 'number_format_error' unless params[:number].to_f.is_a?(Numeric)
    return render 'over_number' if @max_coin < -params[:number].to_f
    # 添加记录
    PokerCoin.create(user: resource.user, typeable: resource.typeable, memo: params[:memo], number: params[:number])
    render 'common/update_success'
  end
end
