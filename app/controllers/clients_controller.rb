class ClientsController < ApplicationController
before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    # @clients = Client.all .where(active: true)
    @clients = policy_scope(Client)
  end

  def show
    authorize @client
  end

  def new
    @client = Client.new
    authorize @client
  end

  def create
    @client = Client.new(client_params)
    authorize @client
    @client.save
    if @client.save
      redirect_to client_path(@client)
    else
      render :new
    end
  end

  def edit
    authorize @client
  end

  def update
    authorize @client
    @client.update(client_params)
    @client.save
    redirect_to client_path(@client)
  end

  def destroy
    authorize @client
    flash[:alert] = "Are you sure?"
    @client.active = false
    redirect_to clients_path
  end

  private

  def client_params
    params.require(:client).permit(:lloguer, :name, :idcard, :address, :postcode, :city, :contactname, :contactphone1, :contactphone2, :contactemail, :comments)
  end

  def set_client
    # @client = current_user
    @client = Client.find(params[:id])
  end
end
