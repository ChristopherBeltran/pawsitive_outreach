class Admin::PetsController < ApplicationController
  before_action :admin_authenticate

  def index
    @pets = Pet.all.order(:name)
    #Class Scope Method
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
      #error for pet being invalid
    end
  end

  def show
    @pet = Pet.find_by(id: params[:id])
  end

  def edit
    @pet = Pet.find_by(id: params[:id])
  end

  def update
    @pet = Pet.find_by(id: params[:id])
    @pet.update(pet_params)
    redirect_to admin_pets_path
  end

  def destroy
  end

private
def pet_params
  params.require(:pet).permit(:name, :age, breed_ids:[], breed_attributes: [:name])
end


end
