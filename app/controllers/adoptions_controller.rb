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
        redirect_to user_adoptions_path(current_user, @adoption)
      else
        redirect_to pets_path
    end
  end

  def show
  end

  def edit
  end

  def destroy
  end

private

def adoption_params
  params.require(:adoption).permit(:user_id, :pet_id, :adoption_date)
end

end
