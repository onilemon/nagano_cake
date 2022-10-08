class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.sum_of_price }
    @order.postage = 800
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
    redirect_to admin_order_path(@order.id)
    else
    render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :postage, :total_payment, :payment_method, :status)
  end
end