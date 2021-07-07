require "pry"
def consolidate_cart(cart)
  # code here
  answer = Hash.new
  cart.each do |item|
    if answer[item.keys[0]] == nil
      answer.merge!(item)
      answer[item.keys[0]].merge!({:count => 1})
    else
      answer[item.keys[0]][:count] += 1
    end
  end
  answer
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    if cart[coupon[:item]] != nil && ((cart[coupon[:item]][:count] - coupon[:num]) >= 0)
      cart[coupon[:item]][:count] -= coupon[:num]
      if cart[coupon[:item] + " W/COUPON"] == nil 
        cart.merge!({coupon[:item] + " W/COUPON" => {:price => coupon[:cost], :clearance => cart[coupon[:item]][:clearance], :count => 1}})
      else
        cart[coupon[:item] + " W/COUPON"][:count] += 1
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |thing, value|
    if value[:clearance]
      cart[thing][:price] = (0.8 * cart[thing][:price]).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0
  cart.each do |keys,values|
    total += (values[:price] * values[:count])
  end

  if total > 100
    total = (total *= 0.9).round(2)
  end

  total
end
