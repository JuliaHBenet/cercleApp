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

  before_save :set_background_color

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


  def create_recurring_events
    if weekly
      next_occurence = eventstart + 7.days
      while(next_occurence < recurrence_ends_at) do
        new_event_attributes = self.attributes.clone
        new_event_attributes.delete("id")
        new_event_attributes['eventstart'] = next_occurence
        new_event_attributes['eventend'] = next_occurence + (eventend - eventstart)

        Event.create(new_event_attributes)

        next_occurence += 7.days
      end
    end
  end

  def set_background_color
    background_colors = {
      1 => "#ff4d4d",
      2 => "#d98cb3",
      3 => "#ffb366",
      4 => "#d5ff80",
      5 => "#99ddff",
      6 => "#80ffff",
      7 => "#8cb3d9",
      8 => "#a366ff",
      9 => "#ffd480",
      10 => "#cccc00",
    }
    self.backgroundColor = background_colors[room_id.to_i] || "#cccccc"
  end


end
