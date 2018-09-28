class Event < ApplicationRecord
  belongs_to :client
  belongs_to :room
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  validates :eventstart, presence: true
  validates :eventend, presence: true

  validate :overlapping_event
  validate :blocking_events

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

  def blocking_events
    if room.name == Room::ESCENARI
      if client.lloguer || representacio

        Event.joins(:room).where(rooms: { name:  ["Descans", "Capella"] }).each do |oa|
          if (eventstart...eventend).overlaps?(oa.eventstart...oa.eventend)
            errors.add(:base, 'Room not available in this period of time')
          end
        end

      end
    elsif room.name.in?(["Descans", "Capella"])

      related_events = Event.joins(:room, :client)
                            .where(rooms: { name:  Room::ESCENARI })
                            .where("clients.lloguer = true OR events.representacio = true")

      related_events.each do |oa|
        if (eventstart...eventend).overlaps?(oa.eventstart...oa.eventend)
          errors.add(:base, 'Room not available in this period of time')
        end
      end


    end
  end

  def block_room
    if event.room == "Escenari" && (event.client.lloguer == true || event.representacio == true)
      "Descans".status = "busy"
      "Capella".status = "busy"
    end
  end


end
