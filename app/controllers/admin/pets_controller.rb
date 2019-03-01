class Admin::PetsController < ApplicationController
  before_action :admin_authenticate

  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
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
  params.require(:pet).permit(:name, :age)
end


end
