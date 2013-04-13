class Salary < ActiveRecord::Base
  # Protected Attributes
  attr_protected :active 

  # Validations
  validates :salary_type, :presence => true, :inclusion => { :in => ["HOURLY", "SALARY"] }
  validates :rate, :presence => true, :numericality => true
  validates :pay_period, :inclusion => { :in => ["WEEKLY", "BIWEEKLY", "MONTHLY"] }
  validates :effective_from, :presence => true
  validates :effective_to, :presence => true

  # Scopes
  scope :active, :where(:active => true)

  # Methods


  # GROUP USER CENTRIC 
  # Determine current salary profile for a given user
  def self.current_for(user)
  	return self.where("user_id = ? and effective_to > ?", user.id, Time.now).active.first
  end


  def set_current_for(user, effective_date = Time.now, expiration_date = 100.years.from_now)
  	Salary.current_for(user).each { |s| s.update_attribute("effective_to", effective_date) }
  	self.update_attributes({:effective_from => effective_date, :effective_to => expiration_date})
  end
  # END GROUP USER CENTRIC

  # INFORMATION FOR API
  def periods_per_month
    case self.pay_period
    when "WEEKLY"
      4
    when "BIWEEKLY"
      2
    when "MONTHLY"
      1
    end
  end

  # END GROUP API
  

end
