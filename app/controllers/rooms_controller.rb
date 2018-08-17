class RoomsController < ApplicationController
  def index
    # @rooms = Room.all
    @rooms = policy_scope(Room)
  end
end
