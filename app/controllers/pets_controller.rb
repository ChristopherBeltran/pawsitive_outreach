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

  def edit
    if current_user == User.find_by(id: params[:user_id])
      @pet = Pet.find_by(id: params[:id])
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    pet = Pet.find_by(id: params[:id])
    pet.update(pet_params)
    redirect_to user_pets_path(current_user)
  end

private

def pet_params
  params.require(:pet).permit(:name)
end


end
