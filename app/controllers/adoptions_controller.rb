class AdoptionsController < ApplicationController

  def index
  end

  def new
    @pet = Pet.find_by(id: params[:pet_id])
    if @pet.users.count == 1
      flash[:notice] = "Pet is already adopted!"
      redirect_to pets_path
    else
    @adoption = Adoption.new
    end
  end

  def create
    @adoption = Adoption.new(adoption_params)
    render json: @adoption, status: 201
    if @adoption.save
        @pet = Pet.find_by(id: params[:pet_id])
        redirect_to edit_user_pet_path(current_user, @pet)
      else
        @pet = Pet.find_by(id: params[:pet_id])
        render :new
        #error for invalid adoption details
    end
  end

  def show
  end

  def edit
  end

private

def adoption_params
  params.require(:adoption).permit(:user_id, :pet_id, :adoption_date, :id)
end

end
