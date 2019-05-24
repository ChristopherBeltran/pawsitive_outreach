class Admin::BreedsController < ApplicationController
  before_action :admin_authenticate

  def index
    @breeds = Breed.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @breeds, status: 200 }
    end 
  end

  def new
  end

  def create
  end

  def show
    @breed = Breed.find_by(id: params[:id])
    @pets = Pet.from_breed(@breed)
  end

  def edit
  end

  def update
  end

  def destroy
  end


end
