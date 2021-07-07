require "pry"
def consolidate_cart(cart)
  # code here
  #creates new hash
  nuhash = {}
  # explores the first level
  cart.each do |item|
    # checks the second level with the items and their info
    item.each do |name, price|
      # binding.pry
      # testing if there is no name
      if nuhash[name] == nil
        # if so we merge the new "count" info
        nuhash[name] = price.merge({:count => 1})
      else
        # other wise we increase the count
        nuhash[name][:count] += 1
      end
    end
  end
  # return the new hash
  nuhash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.keys.include?(coupon[:item])
      count = 0
      while coupon[:num] <= cart[item][:count]
        count += 1
        cart[item + " W/COUPON"] = {price: coupon[:cost], :clearance => cart[item][:clearance], count: count}
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  # going through the items and their info
  cart.each do |item, price|
    # testing if the clearance on the item is true
    if price[:clearance] == true
      # if so apply a clearance discount of 20%
      price[:price] = (price[:price] * 0.8).round(2)
    end
  end
  # return the cart
  cart
end

def checkout(cart, coupons)
  # code here
  # assigning prior methods to variables
  cart = consolidate_cart(cart)
  cartx = apply_coupons(cart, coupons)
  carty = apply_clearance(cartx)
  # making a total amount tracker
  total = 0

  # going through the item list
  carty.each do |name, price|
    # incrementing the total by the price and the amount of items
    total += (price[:price] * price[:count])
  end

  # testing if the total price is over $100
  if total > 100
    # applying a 10% discount to the total amount
    total = (total *= 0.9).round(2)
  end
  total
end
