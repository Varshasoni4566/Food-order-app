class CartsController < ApplicationController

	before_action :set_cart
	before_action :authenticate_request

	def show
	debugger
    @line_items = @cart.line_items.includes(:food)
        if @line_items.present?
          render json: { line_items: @line_items }, status: :ok
        else
          render json: { error: "No items found in the cart" }, status: :not_found
        end
    end

    # def destroy
    # 	debugger
    # 	if @cart.destroy
    # 	render json: {message: "cart is empty"}
    # 	else
	# 	    render json: { error: 'Unable to remove cart.' }, status: :unprocessable_entity
    # end

	private

	def set_cart
      @cart = Cart.find(params[:id])
    end
end
