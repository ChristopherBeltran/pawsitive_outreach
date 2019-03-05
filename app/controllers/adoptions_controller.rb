class AdoptionsController < ApplicationController

  def index
  end

  def new
    @pet = Pet.find_by(id: params[:pet_id])
    @adoption = Adoption.new
  end

  def foster
  end

  def create
    @adoption = Adoption.create(adoption_params)
    @adoption.save
      if @adoption
        @pet = Pet.find_by(id: params[:pet_id])
        redirect_to edit_user_pet_path(current_user, @pet)
      else
        redirect_to pets_path
    end
  end

  def show
  end

  def edit
  end

  def destroy
    current_user.pets.delete(Pet.find_by(id: params[:id]))
    redirect_to user_pets_path(current_user)
  end

private

def adoption_params
  params.require(:adoption).permit(:user_id, :pet_id, :adoption_date, :id)
end

end
