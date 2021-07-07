require"pry"


def consolidate_cart(cart)


consolidated = {}
 cart.each do |item|
   item.each do |k,v|


     if consolidated.keys.include?(k)

       v[:count] += 1
      else

        consolidated[k] = v
        v[:count] = 1


      end
   end

 end
consolidated
end

def apply_coupons(cart, coupons)
  coupons.each do|coupon|
  name = coupon[:item]
      if cart.keys.include?(name) && coupon[:num] <= cart[name][:count]

      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1

        else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost],:clearance => cart[name][:clearance]}
        end
   cart[name][:count] -= coupon[:num]
      end
  end
  cart
end

def apply_clearance(cart)

  cart.each do |k,v|
    if v[:clearance] == true
       v[:price] = v[:price] - (v[:price] * 0.20)

    end
  end
cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  cart_total = 0
  cart.each do |k,v|
    cart_total +=  v[:price] * v[:count]
    if cart_total > 100
      cart_total = cart_total - (cart_total * 0.10)
    end
  end
cart_total
end
