class User < ApplicationRecord

  has_many :orders
  has_one :cart

  require "securerandom"
  has_secure_password

  validates :email, presence: true,uniqueness: true
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true

  attr_accessor :otp 
  before_create :generate_otp

  enum role: { vendor: 0, customer: 1 }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  def self.search(query)
    users = all
    if query.present?
      users = users.where("name LIKE :query OR email LIKE :query OR username LIKE :query", query: "%#{query}%")
    end

    users
  end
  

  private

  def generate_otp
    self.otp = rand(1000..9999).to_s 
  end
end
