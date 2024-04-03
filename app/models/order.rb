class Order < ApplicationRecord
	  has_many :line_items

	def calculate_total_price
		debugger
        self.total_price = line_items.sum(&:subtotal)
    save
  end
end
