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
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
