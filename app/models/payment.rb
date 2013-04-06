class Payment < ActiveRecord::Base
  # Protected Attributes
  # Don't need to protect many because payments are not editable via web
  attr_protected :active

  # Validations
  # Not needed because does not consist of user data

  # Scopes
  scope :active, where(:active => true)
  scope :processed, where(:payment_made => true)

  # Relations
  belongs_to :user
end
