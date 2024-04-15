class UserMailer < ApplicationMailer

    def verification_email(user)
        @user = user
        @otp = @user.otp
        mail(to: @user.email, subject: 'Email Verification')
    end
     
    # every 1.minute, at: '9:00 am' do   
    #     runner 'UserMailer.verification_email(@user)' 
    # end
    # every 1.minute
    # runner 'UserMailer.verification_email(@user)'
end
