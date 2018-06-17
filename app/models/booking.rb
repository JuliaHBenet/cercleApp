class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :room
  belongs_to :user
  validates :activityname, presence: true
  validates :activitydescription, presence: true
  validates :bookingstart, presence: true
  validates :bookingend, presence: true
end
