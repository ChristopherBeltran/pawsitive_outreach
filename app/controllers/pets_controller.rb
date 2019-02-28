class PetsController < ApplicationController
  before_action :user_authenticate

  def index
    if params[:user_id] && current_user.id == params[:user_id]
      @user_pets = current_user.pets
    elsif
      params[:user_id] && current_user.id != params[:user_id]
      redirect_to user_path(current_user)
    end
  else
    @pets = Pet.all
  end
  
end
