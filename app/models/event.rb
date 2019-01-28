class Event < ApplicationRecord
  belongs_to :client
  belongs_to :room
  belongs_to :user
  validates :name, presence: true
  validates :eventstart, presence: true
  validates :eventend, presence: true

  validate :overlapping_event
  validate :blocking_events
  validate :blocking_golfes
  validate :eventend_after_eventstart?


  before_save :set_border_color
  before_save :set_background_color

  attr_accessor :edit_all_occurences

  PENDING = "pending".freeze
  ACCEPTED = "accepted".freeze
  DECLINED = "declined".freeze

  STATUSES = [PENDING, ACCEPTED, DECLINED]

  def to_fullcalendar_hash
    {
      id: id,
      title: title,
      allDay: false,
      start: eventstart,
      end: eventend,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      url: Rails.application.routes.url_helpers.event_path(id),
    }
  end

  def catalan_status
    {
      PENDING => "Pendent",
      ACCEPTED => "Acceptada",
      DECLINED => "Cancel·lada",
    }[status]
  end

  def title
    if representacio
      "[R] #{name}"
    else
      name
    end
  end

  def overlapping_event
    overlapping_event = room.events.where.not(id: id).all

    overlapping_event.each do |oa|
      if (eventstart...eventend).overlaps?(oa.eventstart...oa.eventend)
        errors.add(:base, "Sala no disponible (veure reserva ##{oa.id})")
      end
    end
  end

  def blocking_events
    if room.name == Room::ESCENARI
      if client.lloguer || representacio

        Event.joins(:room).where(rooms: { name:  ["Descans", "Capella"] }).each do |oa|
          if (eventstart...eventend).overlaps?(oa.eventstart...oa.eventend)
            errors.add(:base, 'Sala no disponible (veure Escenari)')
          end
        end

      end
    elsif room.name.in?(["Descans", "Capella"])

      related_events = Event.joins(:room, :client)
                            .where(rooms: { name:  Room::ESCENARI })
                            .where("clients.lloguer = true OR events.representacio = true")

      related_events.each do |oa|
        if (eventstart...eventend).overlaps?(oa.eventstart...oa.eventend)
          errors.add(:base, 'Sala no disponible (veure Escenari)')
        end
      end

    end
  end

  def blocking_golfes
    if room.name == Room::GOLFES
      if eventend.strftime("%H:%M") > "22:00"
        errors.add(:base, 'Sala no disponible a partir de les 22h')
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
        new_event_attributes['parent_event_id'] = id

        Event.create(new_event_attributes)
        next_occurence += 7.days
      end

    elsif monthly_number
      next_occurence = eventstart + 1.month
      while(next_occurence < recurrence_ends_at) do
        new_event_attributes = self.attributes.clone
        new_event_attributes.delete("id")
        new_event_attributes['eventstart'] = next_occurence
        new_event_attributes['eventend'] = next_occurence + (eventend - eventstart)
        new_event_attributes['parent_event_id'] = id

        Event.create(new_event_attributes)
        next_occurence += 7.days
      end

    elsif monthly_day
      next_occurence = eventstart + 4.weeks
      while(next_occurence < recurrence_ends_at) do
        new_event_attributes = self.attributes.clone
        new_event_attributes.delete("id")
        new_event_attributes['eventstart'] = next_occurence
        new_event_attributes['eventend'] = next_occurence + (eventend - eventstart)
        new_event_attributes['parent_event_id'] = id

        Event.create(new_event_attributes)
        next_occurence += 7.days
      end

    end
  end

  def delete_recurring_events
    Event.where(parent_event_id: id).delete_all
  end

  def update_recurring_events
    delete_recurring_events
    create_recurring_events
  end

  def set_border_color
    border_colors = {
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
    self.borderColor = border_colors[room_id.to_i] || "#cccccc"
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


def eventend_after_eventstart?
  if eventend < eventstart
    errors.add :eventend, "ha de ser posterior"
  end
end


end
