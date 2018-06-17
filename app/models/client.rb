class Client < ApplicationRecord
  has_many :bookings
  validates :name, presence: true
  validates :contactname, presence: true
  validates :contactemail, presence: true
end
