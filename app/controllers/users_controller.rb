class UsersController < ApplicationController
  def show
    @user = User.find(params[:id] || current_user.id)
    @relationship = current_user.relationships.build
  end

end