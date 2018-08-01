class Event < ApplicationRecord
  belongs_to :client
  belongs_to :room
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  validates :eventstart, presence: true
  validates :eventend, presence: true
end
