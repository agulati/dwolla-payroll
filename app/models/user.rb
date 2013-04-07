class User < ActiveRecord::Base
  # Protected attributes
  attr_protected :password_hash, :salt, :auth_key, :dwolla_id, :oauth_token, :active, :last_login

  # Validations
  validates :first_name, :presence => true, :length => { :minimum => 2 }
  validates :last_name, :presence => true, :length => { :minimum => 2 }
  validates :address, :presence => true, :length => { :minimum => 2 }
  validates :city, :presence => true, :length => { :minimum => 2 }
  validates :state, :presence => true, :length => { :minimum => 2 }
  validates :postal_code, :presence => true, :length => { :minimum => 6 }
  validates :email, :uniqueness => true, :with => { :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  # Scopes
  scope :active, where(:active => true)
  scope :manager, where(:is_manager => true)

  # Relations
  has_many :withholdings
  has_many :salaries
  has_many :payments

  # methods
  def salary
  	Salary.current_for(self)
  end

  def withholding
    Withholding.current_for(self)
  end

  # GROUP LOGIN
  def set_password(pass)
    self.salt = rand(10000000).to_s
    self.hashed_password = hash_pwd(pass)
    self.auth_key = newpass(16)
    self.save!
  end

  def hash_pwd(pass)
    Digest::SHA2.hexdigest(pass + self.salt)
  end

  def self.authenticate(uname, password)
    user = User.where(:username => uname).first
    if user.blank? || user.hashed_password != user.hash_pwd(password)
      return false
    else 
      user.update_attributes({:last_login => Time.now})
      return user
    end
  end

  private 
  def newpass( len )
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
end
