class Admin::PetsController < ApplicationController
  before_action :admin_authenticate

  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.create(pet_params)
    if @pet.save
      redirect_to admin_pets_path
    else
      redirect_to new_admin_pet_path
    end 
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

private
def pet_params
  params.require(:pet).permit(:name, :age, breed_ids:[], breed_attributes: [:name])
end


end
