class UserMailer < ApplicationMailer

    def verification_email(user,order)
        @user = user
        @otp = @user.otp
        @order = order
        mail(to: @user.email, subject: 'Email Verification')
    end
     
    # every 1.minute, at: '9:00 am' do   
    #     runner 'UserMailer.verification_email(@user)' 
    # end
    # every 1.minute
    # runner 'UserMailer.verification_email(@user)'
end
