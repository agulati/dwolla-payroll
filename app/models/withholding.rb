class Withholding < ActiveRecord::Base
  attr_protected :active, :formula_file
  # Relations
  belongs_to :user

  # Validations
  validates :w4_number, :numericality => true
  validates :additional_withholding_amount, :numericality => true 
  validates :allowances_claimed, :numericality => true

  # Get current withholding for users
  # GROUP USER CENTRIC 
  # Determine current withholding profile for a given user
  def self.current_for(user)
  	return self.where("user_id = ? and effective_to > ?", user.id, Time.now).active.first
  end


  def set_current_for(user, effective_date = Time.now, expiration_date = 100.years.from_now)
  	Withholding.current_for(user).each { |s| s.update_attribute("effective_to", effective_date) }
  	self.update_attributes({:effective_from => effective_date, :effective_to => expiration_date})
  end
  # END GROUP USER CENTRIC

end


# Structure for Withholding
# Federal Income tax 