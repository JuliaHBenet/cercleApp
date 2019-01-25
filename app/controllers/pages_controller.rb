class PagesController < ApplicationController

  def home
  end

  def informes
    @clients = Client.all
    @client = Client.find_by_id(:client_id)
    @events = Event.all
    @event = Event.find_by_id(:event_id)
  end

  def documents
  end

  def calendar
  end

  def print_calendar_picker
  end

  def print_calendar
    render "print_calendar", layout: 'print'
  end


end
