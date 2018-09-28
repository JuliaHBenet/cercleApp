class EventsController < ApplicationController
  before_action :set_event, only:[:show, :edit, :update, :destroy, :accept, :decline]

  before_action :authenticate_user!, only: [:new, :create]
  after_action :set_background_color, only: [:create]

  def index
    # @events = Event.all #.where("DATE(eventend) >= ?", Date.today)
    # @events = Event.where(eventstart: params[:eventstart]..params[:eventend])
    # @events = Event.all
    @events = policy_scope(Event)

    respond_to do |format|
      format.html
      format.json do
        render json: @events.map(&:to_fullcalendar_hash)
      end
    end
  end

  def show
    @event = policy_scope(Event).find(params[:id])
    authorize @event
  end

  def new
    @event = Event.new
    @client = policy_scope(Client).find(params[:client_id])
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @client = policy_scope(Client).find(@event.client_id)
    authorize @event

    @event.user = current_user
    @event.client = @client
    if current_user.role == "admin"
      @event.status = Event::ACCEPTED
    else
      @event.status = Event::PENDING
    end

    if @event.save
      redirect_to calendar_path
    else
      flash[:alert] = "There is an overlapping event"
      render :new
    end
  end

  def edit
    @client = policy_scope(Client).find(@event.client_id)
    authorize @event
  end

  def update
    authorize @event
    @event.update(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def accept
    authorize @event, :accept_or_decline?
    @event.update(status: Event::ACCEPTED)
    redirect_to event_path(@event)
  end

  def decline
    authorize @event, :accept_or_decline?
    @event.update(status: Event::DECLINED)
    redirect_to event_path(@event)
  end

  def destroy
    authorize @event
    @event.user = current_user
    if current_user.role == "admin"
      @event.status = Event::DECLINED
      @event.save
      redirect_to event_path(@event)
    else
      @event.comments = "This event has been preselected to destroy"
      @event.status = Event::PENDING
      @event.save
      redirect_to event_path(@event)
    end

  end

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

# check new eventstart and eventend against all other events booked and
# accepted / pending for that specific room and display error

# set status 1 available and 2 busy and not bookable if busy
# call block_room

  def block_room
    if event.room == "Escenari" && (event.client.lloguer == true || event.representacio == true)
      "Descans".status = "busy"
      "Capella".status = "busy"
    end
  end

  def set_background_color
    @room = policy_scope(Room).find(@event.room_id)
    @event.room = @room
    if @event.room_id == 1
      @event.backgroundColor = "#ff4d4d"
    elsif @event.room_id == 2
      @event.backgroundColor = "#d98cb3"
    elsif @event.room_id == 3
      @event.backgroundColor = "#ffb366"
    elsif @event.room_id == 4
      @event.backgroundColor = "#d5ff80"
    elsif @event.room_id == 5
      @event.backgroundColor = "#99ddff"
    elsif @event.room_id == 6
      @event.backgroundColor = "#80ffff"
    elsif @event.room_id == 7
      @event.backgroundColor = "#8cb3d9"
    elsif @event.room_id == 8
      @event.backgroundColor = "#a366ff"
    elsif @event.room_id == 9
      @event.backgroundColor = "#ffd480"
    elsif @event.room_id == 10
      @event.backgroundColor = "#cccc00"
    else
      @event.backgroundColor = "#cccccc"
    end
    @event.save
  end


  private

  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: "https://accounts.google.com/o/oauth2/auth",
      token_credential_uri: "https://accounts.google.com/o/oauth2/token",
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: calendar_url
    }
  end

  def event_params
    params.require(:event).permit(:lloguer, :status, :document, :representacio, :name,
      :description, :eventstart, :eventend, :activitystart, :activityend, :comments,
      :client_id, :room_id, :user, :backgroundColor, :borderColor)
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
