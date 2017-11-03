ActiveAdmin.register OptionValue do
  config.batch_actions = false

  belongs_to :option_type, optional: true
  navigation_menu :default
  menu false
  actions :nil

  permit_params :name, :option_type_id

  collection_action :quick_new, method: :get do
    @option_type = OptionType.find(params[:option_type_id])
    @option_value = OptionValue.new(option_type: @option_type)
    render 'new', layout: false
  end

  collection_action :quick_create, method: :post do
    @option_value = OptionValue.new(permitted_params[:option_value])
    @option_value.save
    render 'quick_response', layout: false
  end

  collection_action :destroy, method: :delete do
    @option_value = OptionValue.find(params[:id])
    @option_value.destroy
    redirect_back fallback_location: variants_admin_product_path(params[:product_id])
  end
end
