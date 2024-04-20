class Category < ApplicationRecord

	 has_many :foods

	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
    ["foods"]
  	end

    def self.search(query)
        categories = all
    if query.present?
      categories = categories.where("name LIKE :query ", query: "%#{query}%")
    end

    categories
    end
end
