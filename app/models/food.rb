class Food < ApplicationRecord
belongs_to :category
has_many :line_items

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "price", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "line_items"]
  end 



  # def self.search(query)
  #   where("name LIKE ?", "%#{query}%")
  # end

   def out_of_stock?
    !self.in_stock
  end

  # def self.search(query)
  #   where("name LIKE :query", query: "%#{query}%")
  # end

  def self.search(query)
    foods = all
    if query.present?
      foods = foods.where("name LIKE :query OR price LIKE :query", query: "%#{query}%")
    end
    # foods = foods.where("name LIKE ?", "%#{name_query}%") if name_query.present?
    # foods = foods.where("price <= ?", price_query.to_i) if price_query.present?
    foods
  end
end
