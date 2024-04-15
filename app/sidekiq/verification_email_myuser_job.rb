class VerificationEmailMyuserJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find_by(id: user_id)  
    UserMailer.verification_email(user).deliver_now
  end
end
