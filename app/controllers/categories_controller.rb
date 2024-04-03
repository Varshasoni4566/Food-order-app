class CategoriesController < ApplicationController

   before_action :authenticate_request

  def index
    @categories = Category.all 
    render json: @categories
  end
end
