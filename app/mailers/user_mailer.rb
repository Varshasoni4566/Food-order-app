class UserMailer < ApplicationMailer
	def verification_email(user)
    @user = user
    @otp = @user.otp

    mail(to: @user.email, subject: 'Email Verification')
  end
end
