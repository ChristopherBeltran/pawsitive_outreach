class UsersController < ApplicationController

  def new
    @user = User.new
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

def user_params
  require(:user).permit(:email, :name, :phone_number, :address, :password, :password_confirmation)
end 

end
