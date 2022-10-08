class Admin::OrderDetailsController < ApplicationController
  def update
    @order_details = OrderDetail.find(params[:id])
    @order = @order_details.order
    if @order_details.update(order_detail_params)
    redirect_to admin_order_path(@order.id)
    else
    render :show
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :price, :amount, :making_status)
  end
end
