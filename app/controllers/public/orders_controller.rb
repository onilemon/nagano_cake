class Public::OrdersController < ApplicationController
  def new
  @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @order = Order.new(order_params)
    @order.total_payment = @total
    @order.postage = 800
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_number] == "2"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_number] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.status = params[:order][:status].to_i
    @order.save!
    current_customer.cart_items.each do |cart_item|
      @order_detail = @order.order_details.build
      @order_detail.item_id = cart_item.item_id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount
      @order_detail.making_status = 0
      @order_detail.save
    end
    redirect_to complete_orders_path
  end

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.sum_of_price }
    @order.postage = 800
  end



  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :postage, :total_payment, :payment_method)
  end
end
