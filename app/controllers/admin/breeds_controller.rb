class Admin::BreedsController < ApplicationController
  before_action :admin_authenticate

  def index
    breeds = Breed.all.order(:name)
    respond_to do |format|
      format.html { render :index }
      format.json { render json: breeds, status: 200 }
    end 
  end

  def new
  end

  def create
  end

  def show
    breed = Breed.find_by(id: params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: breed, status: 200 }
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end


end
