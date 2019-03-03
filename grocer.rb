require "pry"

def consolidate_cart(cart)
  consolidated = {}
  cart.each do |item|
    item.each do |item_name,item_data|
      if consolidated.keys.include?(item_name)
        item_data[:count] += 1
      else
        consolidated[item_name] = item_data
        item_data[:count] = 1
      end
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.keys.include?(coupon[:item])
      coupon_count = 0
      while coupon[:num] <= cart[item][:count]
        coupon_count += 1
        cart[item + " W/COUPON"] = {price: coupon[:cost], :clearance => cart[item][:clearance], count: coupon_count}
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.collect do |x,y|
    if y[:clearance]
      y[:price] = (y[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |x,y|
    total += (y[:price] * y[:count])
  end
  if total > 100
    total = (total *= 0.9).round(2)
  end
  total
end
