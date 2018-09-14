class Event < ApplicationRecord
  belongs_to :client
  belongs_to :room
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  validates :eventstart, presence: true
  validates :eventend, presence: true

  PENDING = "pending".freeze
  ACCEPTED = "accepted".freeze
  DECLINED = "declined".freeze

  STATUSES = [PENDING, ACCEPTED, DECLINED]

  def to_fullcalendar_hash
    {
      id: id,
      title: name,
      allDay: false,
      start: eventstart,
      end: eventend,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
    }
  end

end
