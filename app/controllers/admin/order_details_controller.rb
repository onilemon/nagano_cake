class Admin::OrderDetailsController < ApplicationController
  def update
    @order_details = OrderDetail.find(params[:id])
    @order = @order_details.order
    if @order_details.update(order_detail_params)
      if params[:order_detail][:making_status] == "production"
        @order.update(status: "production")
      elsif @order.order_details.count == @order.order_details.where(making_status:"completed").count
        @order.update(status: "shipping")
      end
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
