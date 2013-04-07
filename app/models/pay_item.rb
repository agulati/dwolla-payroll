class PayItem < ActiveRecord::Base
  # Protected Attributes
  attr_protected :active 

  # Validations
  validates :unit_amount, :numericality => true
  validates :total, :numericality => true
  validates :quantity, :numericality => true

  # Relations
  belongs_to :user
end
