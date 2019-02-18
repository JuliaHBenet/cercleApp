class Client < ApplicationRecord
  has_many :events
  validates :name, presence: true
  validates :contactname, presence: true
  validates :contactemail, presence: true

  def temps_acumulat
    temps_acumulats = 0
    events.each do |event|
      if ((event.eventend - event.eventstart)/1.hour) > 0
        temps_acumulats += (event.eventend - event.eventstart)
      end
    end
    return temps_acumulats/1.hour
  end

end
