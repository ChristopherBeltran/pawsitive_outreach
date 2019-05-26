class PetsController < ApplicationController
  before_action :user_authenticate

  def index
      pets = Pet.without_owner.sort_by(&:name)
      respond_to do |format|
        format.html { render :index }
        format.json { render json: pets, status: 200 }
    end
  end

  def mypets
    if params[:user_id] != nil && current_user == User.find_by(id: params[:user_id])
      user_pets = current_user.pets
      respond_to do |format|
        format.html { render :mypets }
        format.json { render json: user_pets, status: 200 }
      end
    else
      redirect_to user_path(current_user)
    end
  end 

  def show
    @pet = Pet.find_by(id: params[:id])
    render json: @pet, status: 200
  end 

  def edit
      @pet = Pet.find_by(id: params[:id])
      @pet.users.each do |user|
        redirect_to root_path unless user.id == current_user.id
      end
  end

  def update
    pet = Pet.find_by(id: params[:id])
    pet.update(pet_params)
    redirect_to my_pet_index_url(current_user)
  end

private

def pet_params
  params.require(:pet).permit(:name)
end


end
