class UsersController < ApplicationController

	skip_before_action :authenticate_request, only: [:create]
	before_action :set_user, only: [:show]


	def create
		# debugger
		@user = User.new(user_params)
		if @user.save 
			UserMailer.verification_email(@user).deliver_now
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


	private 
	
	def user_params
	   params.permit(:username, :email, :password, :name)

	end

	 def set_user
    	@user=User.find(params[:id])
    end
end
