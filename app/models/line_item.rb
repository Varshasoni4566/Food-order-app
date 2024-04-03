class LineItem < ApplicationRecord

  belongs_to :cart
  belongs_to :food 
  belongs_to :order, optional: true

  def subtotal
    debugger
     return 0 if quantity.nil? || food.nil? || food.price.nil?
     quantity * food.price.to_f
  end
end
