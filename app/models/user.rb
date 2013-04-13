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
  has_many :pay_items

  # methods
  def salary
  	Salary.current_for(self)
  end

  def withholding
    Withholding.current_for(self)
  end

  # Returns the sum of pretax earnings in the current year
  def ytd_earnings
    self.pay_items.active.within_daterange(Date.civil(Date.today.year - 1), Time.now).sum(:total)
  end
end
