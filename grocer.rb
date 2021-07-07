require 'pry'

def consolidate_cart(cart)
  ans = {}
  cart.each {|x|
    x.each {|x,y|
      if !ans[x]
        ans[x] = y 
      end 
      if !ans[x][:count]
        ans[x][:count] = 1 
      else 
        ans[x][:count] += 1
      end
    }
  }
  ans 
end

def apply_coupons(cart, coupons)
  coupons.each_with_index {|x,y|
    if cart[coupons[y][:item]]
      if cart[coupons[y][:item]][:count] >= coupons[y][:num]
        cart["#{coupons[y][:item]} W/COUPON"] = {price: coupons[y][:cost], clearance: cart[coupons[y][:item]][:clearance], count: (cart[coupons[y][:item]][:count]/coupons[y][:num]).floor}
        cart[coupons[y][:item]][:count] = cart[coupons[y][:item]][:count]%coupons[y][:num]
      end
    end
  }
  cart
end

def apply_clearance(cart)
  cart.each {|x,y|
    if cart[x][:clearance] === true 
      cart[x][:price] = (cart[x][:price]*0.80).round(1)
    end
  }
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0 
  cart.each {|x,y|
    total = total + cart[x][:price]*cart[x][:count]
  }
  if total > 100
    total = total*0.9
  end
  total
end
