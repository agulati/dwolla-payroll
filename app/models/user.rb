class User < ActiveRecord::Base
<<<<<<< HEAD
<<<<<<< HEAD
  attr_accessible :oauth_token, :dwolla_id
=======
  # attr_accessible :title, :body
>>>>>>> Add models & controllers
=======
  # Protected attributes
  attr_protected :password_hash, :salt, :auth_key, :dwolla_id, :active, :last_login

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
  
>>>>>>> More Models
end
