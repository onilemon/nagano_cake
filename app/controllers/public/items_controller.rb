class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).order(created_at: :desc).limit(8)
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price)
  end
end
