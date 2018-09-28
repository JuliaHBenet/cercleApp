class Event < ApplicationRecord
  belongs_to :client
  belongs_to :room
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  validates :eventstart, presence: true
  validates :eventend, presence: true

  validate :overlapping_event

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


  def overlapping_event
    overlapping_event = room.events.all

    overlapping_event.each do |oa|
      if (eventstart...eventend).overlaps?(oa.eventstart...oa.eventend)
        errors.add(:base, 'Room not available in this period of time')
      end
    end
  end


end
