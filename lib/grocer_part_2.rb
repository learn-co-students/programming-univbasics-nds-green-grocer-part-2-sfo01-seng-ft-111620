require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    cart.each do |grocery|
      if coupon[:item] == grocery[:item] && grocery[:count] >= coupon[:num]
        grocery[:count] -= coupon[:num]
        cart << {
          item: coupon[:item] + " W/COUPON",
          price: coupon[:cost] / coupon[:num],
          clearance: grocery[:clearance],
          count: coupon[:num]
        }
      end
    end 
  end
  return cart
end

def apply_clearance(cart)
  cart.each do |grocery|
    if grocery[:clearance] == true
      grocery[:price] /= (1.25)
    end
  end
  return cart
end

def checkout(cart, coupons)
  consolidate = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidate, coupons)
  all_discounts = apply_clearance(applied_coupons)
  total = 0
  all_discounts.each do |grocery|
    total += grocery[:price] * grocery[:count]
  end
  if total > 100
    return total * 0.9
  else
    return total
  end
end
