require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart = []
  cart.each do |each_item|
    if find_item_by_name_in_collection(each_item[:item], coupons)
      coupon_item = find_item_by_name_in_collection(each_item[:item], coupons)
      coupon_item[:price] = coupon_item[:cost]/coupon_item[:num]
      coupon_item[:item] += " W/COUPON"
      coupon_item[:clearance] = each_item[:clearance]
      coupon_count = 0 
      while each_item[:count] >= coupon_item[:num] do   
        each_item[:count] -= coupon_item[:num]
        coupon_count += coupon_item[:num]
      end 
      coupon_item[:count] = coupon_count
      cart.unshift(coupon_item)
    end
  end    
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |each_item|
    if each_item[:clearance]
      each_item[:price] *= 0.8
    end
  end 
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  consolidated = consolidate_cart(cart)
  consolidated_coupons = apply_coupons(consolidated, coupons)
  consolidated_clearance_coupons = apply_clearance(consolidated_coupons)
  total = 0.to_f 
  
  consolidated_clearance_coupons.each do |each_item|
    total += each_item[:price] * each_item[:count]
  end  
    if total > 100.0
      return (total*0.9).floor(2)
    end
    (total).floor(2) 
end
