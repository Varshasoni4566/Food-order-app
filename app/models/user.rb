class User < ApplicationRecord

  has_many :orders
  has_one :cart

  require "securerandom"
  has_secure_password

  validates :email, presence: true
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true

  attr_accessor :otp 
  before_create :generate_otp

  private

  def generate_otp
    self.otp = rand(1000..9999).to_s 
  end
end
