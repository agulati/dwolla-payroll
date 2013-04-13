class PayItem < ActiveRecord::Base
  # Protected Attributes
  attr_protected :active 

  # Validations
  validates :unit_amount, :numericality => true
  validates :total, :numericality => true
  validates :quantity, :numericality => true

  # Relations
  belongs_to :user

  # Scopes
  scope :active, where(:active => true)
  scope :within_daterange, lambda do |start, fin|
    self.where('effective_date > ? and effective_date < ?', start, fin)
  end
end
