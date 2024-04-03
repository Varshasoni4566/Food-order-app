require 'fcm'
class OrdersController < ApplicationController

	 before_action :authenticate_request


	def create
		debugger
	    @order = Order.new
	    @order.save
	        send_push_notification("Your order has been placed.")
		    current_cart.line_items.each do |line_item|
		    line_item.update(order: @order)
		    end
		    @order.calculate_total_price
		    current_cart.destroy
		        render json: {order: @order, message: "your order is placed successfully"}
    end

    def destroy
    	#debugger
    	@order = Order.find(params[:id])
    	if @order.present?
    	@order.destroy
    	send_push_notification("your order has been cancelled")
    		render json:  {order: @order, message: "Order is cancelled"}
    	else
    		render json: {message: "Unable to cancel your order"}
    	end
    end

    def index 
    	debugger
    	@order = Order.all 
    	if @order.present?
    		render json: @order
    	else
    		render json: {message: "no order is availble"}
    	end
    end

    private 

    def send_push_notification(message)
	    fcm = FCM.new("AAAAcy6Wh7I:APA91bGbMPppgS3SrHd361fwyQNNCjf9FXPFQV5sAybSAOrq950RTGbBBT4qtkVd-3Li6y2y7RdLa7plS8P5YL3gXqkgJ3iHHpM8r8K2V_G8-PAxCWLAleUl07lPtsOOHH6WEsA5brSv")
	    registration_ids = ["dls6-BJ4na-8SsDcf3oTfo:APA91bHt-0w5KNdh1oVt3Kj78DdJoDGDQ_q2hc9hwIYlDxhBhRi19RndY7eREAmxGqO7qOPzE-hAZezG_7bMo7-I3lQAawSZN4fpkdEja9jVaHpD3j_05z7yeCfmvf-_JHL6NLFHu-0v"] 
	    options = { data: { message: message } }
	    response = fcm.send(registration_ids, options)
    end
end

