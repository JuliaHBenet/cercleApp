class Client < ApplicationRecord
  has_many :events
  validates :name, presence: true
  validates :contactname, presence: true
  validates :contactemail, presence: true
end
