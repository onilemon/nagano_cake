@total_price = 0

current_customer.cart_items.each do |ci| # point1: eachを使う
  # ciに紐づくitemの値段 * 数量 (小計)
  @total_price += 小計 # point2: 足し上げる
end

puts @total_price
