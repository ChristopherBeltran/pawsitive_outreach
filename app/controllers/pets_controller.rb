class PetsController < ApplicationController
  before_action :user_authenticate

  def index
    if params[:user_id] == nil
      @pets = Pet.without_owner.sort_by(&:name)
    elsif params[:user_id] != nil && current_user == User.find_by(id: params[:user_id])
      @user_pets = current_user.pets
    else
      redirect_to user_path(current_user)
    end
  end


end
