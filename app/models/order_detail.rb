class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def sum_of_price
    price * amount
  end

  enum making_status: { impossible: 0, waiting: 1, production: 2, completed: 3}
end
