class EventsController < ApplicationController
  before_action :set_event, only:[:show, :edit, :update, :destroy, :accept, :decline]

  def index
    # @events = Event.all #.where("DATE(eventend) >= ?", Date.today)
    @events = Event.where(eventstart: params[:eventstart]..params[:eventend])
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.save
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def accept
    @event.status = 1
    @event.save
    redirect_to event_path(@event)
  end

  def decline
    @event.status = 2
    @event.save
    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end



  private

  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: calendar_url
    }
  end

  def event_params
    params.require(:event).permit(:lloguer, :status, :document, :representacio, :name, :description, :eventstart, :eventend, :activitystart, :activityend, :comments, :client, :room, :user)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_client
    @client = Client.find(params[:client_id])
  end
end
