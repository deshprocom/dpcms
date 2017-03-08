class Admin::PurchaseOrders::AttributesController < ApplicationController
  def update
    @purchase_order = PurchaseOrder.find(params[:purchase_order_id])
    if @purchase_order.update(price: permit_params[:order_price])
      respond_to do |format|
        format.json { render :json => { message: '更新成功' } }
      end
    end
  end

  private

  def permit_params
    params.permit(:order_price)
  end
end
