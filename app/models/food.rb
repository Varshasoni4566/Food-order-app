class Food < ApplicationRecord
	
belongs_to :category
has_many :line_items

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "price", "updated_at"]
  end

  def self.search(query)
    where("name LIKE ?", "%#{query}%")
  end

   def out_of_stock?
    !self.in_stock
  end

end
