class LineItemsController < ApplicationController

	# before_action :set_line_item
	before_action :authenticate_request

	def create
		debugger
		@food =  Food.find_by(category_id: params[:category_id])
	    @line_item = current_cart.line_items.build(food: @food)
	    if @line_item.new_record?
           @line_item.quantity = 1
        else
	      @line_item.quantity ||= 0
	      @line_item.quantity += 1
	    end
        if @line_item.save
            render json: { line_item: @line_item, message: 'Food was successfully added to cart' }, status: :created
        else
            render json: { error: 'Unable to add product to cart' }, status: :unprocessable_entity
 	    end
 	end

 	def update
 		# debugger
 		@item = LineItem.find(params[:id])
 		if @item.present?
	 		@item.update(item_params)
	 		render json: @item
	 	else
	 		render json: {message: "not increased"}
	 	end
 	end

 	def index
 		# debugger
	    @line_items = current_cart.line_items.includes(:food)
	    if @line_items.present?
	        render json: { line_items: @line_items }, status: :ok
	    else
	    	render json: {message: "no items are here."}
	    end
    end

 	def destroy
        if @line_item.destroy
		    render json: { message: 'Food was successfully removed from cart.', line_item_id: @line_item.id }, status: :ok
		  else
		    render json: { error: 'Unable to remove product from cart.' }, status: :unprocessable_entity
		  end
    end

	private
   
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def item_params
    	params.require(:line_item).permit(:quantity)
    end
end
