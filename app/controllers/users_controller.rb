class UsersController < ApplicationController
  def index
    # @users = User.all
    @users = policy_scope(User)
  end
end
