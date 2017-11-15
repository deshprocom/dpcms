# rubocop:disable Metrics/BlockLength
ActiveAdmin.register ProductShipment, namespace: :shop do
  belongs_to :product_order
  menu false
  navigation_menu :default

  controller do
    before_action :set_product_order, only: [:new, :create, :edit, :update]

    def new
      if @product_order.product_shipment.blank?
        @product_shipment = ProductShipment.new(product_order: @product_order)
      else
        render :repeat_error
      end
    end

    def create
      shipping_company = ExpressCode.find(product_shipment_params[:express_code_id])&.name
      update_params = product_shipment_params.merge!(shipping_company: shipping_company, product_order: @product_order)
      render :repeat_error unless @product_order.product_shipment.blank?
      @product_shipment = ProductShipment.new(update_params)
      @product_order.shipped if @product_shipment.save
    end

    def set_product_order
      @product_order = ProductOrder.find(params[:product_order_id])
    end

    def product_shipment_params
      params.require(:product_shipment).permit(:express_code_id,
                                               :shipping_number)
    end
  end
end