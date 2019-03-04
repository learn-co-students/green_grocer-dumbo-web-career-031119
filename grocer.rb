def consolidate_cart(cart)
  # code here
  new_obj = {}
  cart.each do |item|
    item.each do |food, info|
      new_obj[food] ||= {}
      new_obj[food] = info
      # bang operator here to see if there is a "count" key in the obj. If there isn't we give it a count key with an intial value of 1.
      if !new_obj[food][:count] 
        new_obj[food][:count] = 1
      else 
        new_obj[food][:count] += 1
      end
    end
  end
  new_obj
end

def apply_coupons(cart, coupons)
  # code here
  new_obj = {}
  cart.each do |food, info|
    new_obj[food] ||= {}
    new_obj[food] = info
    coupons.each do |coupon|
      if coupon[:item] == food
        # checking if the original count is greater than the coupon count bc if it was smaller then obv the coupon can't be applied
        if new_obj[food][:count] > coupon[:num]
          new_obj[food][:count] -= coupon[:num]
          if !new_obj[food + " W/COUPON"]
            new_obj[food + " W/COUPON"] = {:price => coupon[:cost], :clearance => new_obj[food][:clearance], :count => 1}
          else 
            new_obj[food + " W/COUPON"][:count] += 1
          end
        end
      end      
    end
  end
  new_obj
end

def apply_clearance(cart)
  # code here
  new_obj = {}
  cart.each do |food, info|
    info.each do |deet, val|
      new_obj[food] ||= {}
      new_obj[food] = info
      if deet == :clearance && val == true 
        new_obj[food][:price] = (new_obj[food][:price] * 0.80).round(2)
      end
    end
  end
  new_obj
end

def checkout(cart, coupons)
  # code here.
  total = 0.0
  new_cart = consolidate_cart(cart)
  new_cart2 = apply_coupons(new_cart, coupons)
  new_cart3 = apply_clearance(new_cart2)

  
  new_cart3.each do |food, info|
    total += info[:price] * info[:count]
  end
  
  if total > 100
    return total * 0.9
  else 
    return total
  end

end
