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
    foster?
    @adoption = Adoption.create(adoption_params)
    @adoption.save
    if @adoption
      redirect_to user_adoptions_path(@user, @adoption)
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
  params.require(:adoption).permit(:user_id, :pet_id, :adoption_date, :foster, :end_date)
end

def foster?
  if params[:adoption][:foster] == true
    render :foster
  end
end


end
