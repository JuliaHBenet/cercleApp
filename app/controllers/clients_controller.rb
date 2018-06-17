class ClientsController < ApplicationController
before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all #.where(active: true)
  end

  def show

  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.save
    if @client.save
      redirect_to client_path(@client)
    else
      render :new
    end
  end

  def edit

  end

  def update
    @client.update(client_params)
    @client.save
    redirect_to client_path(@client)
  end

  # def destroy
  #   alert: are you sure?
  #   @user.active = false
  #   redirect_to users_path
  # end

  private

  def client_params
    params.require(:client).permit(:lloguer, :name, :idcard, :address, :postcode, :city, :contactname, :contactphone1, :contactphone2, :contactemail, :comments)
  end

  def set_client
    # @client = current_user
    @client = Client.find(params[:id])
  end
end
