class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food 
  belongs_to :order, optional: true

  def subtotal
     return 0 if quantity.nil? || food.nil? || food.price.nil?
     quantity * food.price.to_i
  end

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "food_id", "id", "id_value", "order_id", "quantity", "updated_at"]
  end  
end
