# class VerificationEmailMyuserJob
#   include Sidekiq::Job

#   def perform(user_id)
#     users = User.all   
#     users.each do |user|
#      orders_date, user = Setting.email_setting(user)
#      orders_date.each do |order|
#       UserMailer.verification_email(user,order).deliver_now
#     end
#     # user = User.find_by(id: user_id)  
#     # UserMailer.verification_email(user).deliver_now
#     end
#   end
# end
