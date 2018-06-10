class User < ApplicationRecord
  has_many :locations, :dependent => :destroy
  accepts_nested_attributes_for :locations

  # validates :dob,  presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },  presence: true
  validates :age, numericality: true,  presence: true
  validates :first_name, :last_name, length: { maximum: 30 },  presence: true

  validates :mobile,:presence => true,
  :numericality => true,
  :length => { :minimum => 10, :maximum => 15 }

end
