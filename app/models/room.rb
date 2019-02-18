class Room < ApplicationRecord
  has_many :events
  validates :name, presence: true

  ESCENARI = "Escenari".freeze
  GOLFES = "Golfes". freeze

end
