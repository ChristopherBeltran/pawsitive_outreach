class Admin::BreedsController < ApplicationController
  before_action :admin_authenticate

  def index
    @breeds = Breed.all
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
