class UsersController < ApplicationController

	skip_before_action :authenticate_request, only: [:create]
	before_action :translate_params, :set_user, only: [:show]


	def create
		debugger
		@user = User.new(user_params)
		if @user.save 
			UserMailer.verification_email(@user).deliver_later
			render json: { user: @user, otp: @user.otp }, status: :created
		else
			render json: {errors: @user.errors.full_messages}
		end
	end

	def show
		render json: @user, status: :ok
    end

    def verify_email
	    @user = User.find_by(email: params[:email])
	    if @user && @user.otp == params[:otp]
	      @user.update(email_verified: true) 
	      redirect_to root_path, notice: 'Email verified successfully.'
	    else
	      flash.now[:alert] = 'Invalid OTP.'
	      render :verify_email
	    end
 	end

 	def index
		debugger
		@message = params[:message]
		@translation = I18n.t(@message)
		render json: @translation
	end

 	# def index
    #     debugger
 	# 	 @message = params[:message]
 	# 	 I189.locale = :en
 	# 	 @translation = I18n.t(@message, locale: :ar)
 	# 	 render json: @translation
 	# end


	private 
	
	def user_params
	   params.permit(:username, :email, :password, :name, :role)

	end

	 def set_user
    	@user=User.find(params[:id])
    end

    def translate_params
    	debugger
		locale_key = params[:locale] || 'en' 
		I18n.locale = locale_key.to_sym

	end
end
