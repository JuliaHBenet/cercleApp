class PagesController < ApplicationController

  def home
  end

  def informes
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
