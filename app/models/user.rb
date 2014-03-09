class User < ActiveRecord::Base
  has_secure_password
  validates_confirmation_of :password

  validates :login, :email, presence: true
  validates :password, :password_confirmation, length: { in: 6..20 }, presence: true, on: :create
end
