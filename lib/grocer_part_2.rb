require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # REMEMBER: This method **should** update cart
  coupons.each do |couponHash|
    currentItem = find_item_by_name_in_collection(couponHash[:item], cart)
    if currentItem && currentItem[:count] >= couponHash[:num]
      cart << {:item => currentItem[:item] + " W/COUPON", :price => couponHash[:cost] / couponHash[:num], :clearance => currentItem[:clearance], :count => couponHash[:num]}
      currentItem[:count] -= couponHash[:num]
    end
  end
  return cart
end

def apply_clearance(cart)
  cart.each do |itemHash|
    if itemHash[:clearance] == true
      itemHash[:price] = (0.8 * itemHash[:price]).round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
 # Call consolidate_cart
 # Call apply_coupons && apply_clearance
 # Iterate thru mutated cart and get a grand total with each hash's price * count
 # If grand total over 100, apply 10% discount 
 bigCart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
 grandTotal = 0
 bigCart.each do |itemHash|
   grandTotal += itemHash[:price] * itemHash[:count]
 end
 grandTotal >= 100? grandTotal * 0.9 : grandTotal
end






