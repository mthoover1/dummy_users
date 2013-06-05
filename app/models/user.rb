class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  before_save :encrypt_password
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates_confirmation_of :password
  

  def self.authenticate(name, password)
    return false if name.empty? || password.empty?
    user = User.find_by_name(name)
    BCrypt::Password.new(user.password) == password 
  end
      

  private

  def encrypt_password
    self.password = BCrypt::Password.create(self.password)
  end

end
