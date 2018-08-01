class PagesController < ApplicationController
  # skip_before_action :authenticate_registration!, only: :home
  def home
  end
  def informes
  end
  def documents
  end
  def seccio
    @seccio = Client.where(lloguer: false)
  end
  def calendar
  end
end
