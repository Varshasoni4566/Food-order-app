class FoodsController < ApplicationController

  before_action :authenticate_request

  def index
    @food = Food.all 
    render json: @food
  end

  def search_food
    if params[:search].present?
    @foods = Food.where("name LIKE ?", "%#{params[:search]}%")
    if @foods.any?
      render json: @foods, status: :ok
    else
      render json: { error: "No matching foods found" }, status: :not_found
    end
  else
    @foods = Food.all
    render json: @foods, status: :ok
  end
  end
end
