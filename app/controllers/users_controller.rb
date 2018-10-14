class UsersController < ApplicationController
  def index
    # @users = User.all
    @users = policy_scope(User)
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end
end
