class BookingsController < ApplicationController
  before_action :set_booking, only:[:show, :edit, :update, :destroy, :accept, :decline]

  def index
    @bookings = Booking.all #.where("DATE(bookingend) >= ?", Date.today)
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :edit
    end
  end

  def accept
    @booking.status = 1
    @booking.save
    redirect_to booking_path(@booking)
  end

  def decline
    @booking.status = 2
    @booking.save
    redirect_to booking_path(@booking)
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end



  private

  def booking_params
    params.require(:booking).permit(:lloguer, :status, :document, :representacio, :activityname, :activitydescription, :bookingstart, :bookingend, :activitystart, :activityend, :comments, :client, :room, :user)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_client
    @client = Client.find(params[:client_id])
  end
end
