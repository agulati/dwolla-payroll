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

  # Returns a hashmap with keys :withholdings
  def calculate_taxes_with_formula_for(amount)
  	require "#{Rails.root}/formulas/us/federal.rb"
  	require "#{Rails.root}/formulas/#{self.formula_file}"

  	# Need to pass in YTD earnings because certain taxes are capped at a certain amount
  	fedcalc(amount, self.user.ytd_earnings) + localcalc(amount, self.user.ytd_earnings)
  end

  def calculate_taxes_with_api_for(amount)

  	# Specify API parameters
  	# Num of pay periods per year
  	fpp = self.user.salary.periods_per_month * 12
  	# Married Status
  	ffs = (self.is_married) ? "Married" : "Single"
  	# Number of W4 allowances
  	fa = self.w4_number
  	# Gross Pay for Current period
  	fgp = amount
  	# Pre-Tax Contribution to 401k
  	fpr = 0.0
  	# FICA Gross Pay:
  	figp = fgp 
  	# Gross Pay Plus 

  	# Additional Withholding Amount
  	fad = self.additional_withholding_amount
  	# Basic request
  	`http://www.withholding32.com/api/wh32calc.php?userid=T14X55734&fpp=#{fpp}&ffs=#{ffs}d&fa=#{f}&fgp=#{fgp}&figp=#{figp}&fiytd=0&fad=#{fad}`
  end
  # END GROUP USER CENTRIC

end


# Structure for Withholding
# Federal Income tax 