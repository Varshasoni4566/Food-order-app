class SearchController < ApplicationController
  def search
    @query = params[:query] 
     results = global_search(@query)
     render json: results
  end

  private

 #  def global_search(query)
 #    results = {}
 #    user_value = User.search(query)
 #    food_value = Food.search(query)
 #    category_value = Category.search(query)
 #    results[:users] = user_value if user_value.present?
 #    results[:foods] = food_value if food_value.present?
 #    results[:categories] = category_value if category_value.present?

 #    results
 # end

 def global_search(query)
  results = {}
  search_models = {
    User => :users,
    Food => :foods,
    Category => :categories
  }
  search_models.each do |model, key|
    search_result = model.search(query)
    results[key] = search_result if search_result.present?
  end
  results
end
end
