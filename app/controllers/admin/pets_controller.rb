class Admin::PetsController < ApplicationController
  before_action :admin_authenticate
  before_action :find_pet, only: [:show, :edit, :update]

  def index
    pets = Pet.all.order(:name)
    #Class Scope Method
    respond_to do |format|
      format.html { render :index }
      format.json { render json: pets, status: 200 }
    end 
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.create(pet_params)
    render json: @pet, status: 201
    if !@pet.save
      render :new
      #error for pet being invalid
    end
  end

  def show
    pet = Pet.find_by(id: params[:id])
    render json: pet, status: 200
  end

  def edit
    #@pet = Pet.find_by(id: params[:id])
    #find_pet
  end

  def update
    #@pet = Pet.find_by(id: params[:id])
    @pet.assign_attributes(pet_params)
    if @pet.valid?
      @pet.save(pet_params)
      flash[:notice] = "#{@pet.name} successfully updated!"
      redirect_to admin_pets_path
    else
      render :edit
    end
  end

  def destroy
  end

private
def pet_params
  params.require(:pet).permit(:name, :age, breed_ids:[], breed_attributes: [:name])
end

def find_pet
  @pet = Pet.find_by(id: params[:id])
end



end
