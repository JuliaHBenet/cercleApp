class PagesController < ApplicationController
  # skip_before_action :authenticate_registration!, only: :home
  def home
  end

  def informes
  end

  def documents
  end

  def calendar
    if params[:print]
      render "calendar", layout: 'print'
    end
  end
end
