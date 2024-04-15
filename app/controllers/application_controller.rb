class ApplicationController < ActionController::Base

	require 'stripe'

	protect_from_forgery with: :null_session
	include JsonWebToken
	before_action :authenticate_request
	helper_method :current_cart
	helper_method :current_user

    Stripe.api_key = "sk_test_51OpPd7SDqgWY1ukHPzf26dUpYygIh9VcSzssXHcwr20BOBdST0OAZLiy9nz9P4P8zzz0OMBG5OBsVLF29GB2Gqe400JTxl4aUX"


	private
	def authenticate_request
		header = request.headers["Authorization"]
		header = header.split(' ').last if header
		if header.present?
		    begin
		      decoded = jwt_decode(header)
		      @current_user = User.find(decoded[:user_id])
		    #   unless @current_user.admin?
            #         render json: { error: 'Authorization token is required' }, status: :unauthorized
            # end
		    rescue JWT::DecodeError => e
		      render json: { error: 'Invalid JWT token' }, status: :unauthorized
		    end
		else
		    render json: { error: 'Authorization token is  missing' }, status: :unauthorized
       end
	end
	
    def current_cart
        @current_cart ||= Cart.find_or_create_by(user_id: @current_user.id)
    end

    # def current_user
   	# 	@current_user ||= User.find_or_create_by(user_id: @current_user.id)
    # end


	rescue_from CanCan::AccessDenied do |exception|
	    respond_to do |format|
	    format.json { render json: { error: "Access denied." }, status: :forbidden }
	    end
	end
end
