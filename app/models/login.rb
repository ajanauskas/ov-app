class Login
  include ActiveModel::Model

  attr_accessor :login, :password

  validate :login, :password, presence: :true
end
