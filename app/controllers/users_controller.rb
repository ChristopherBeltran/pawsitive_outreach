class UsersController < ApplicationController
  before_action :user_authenticate, only: [:show, :edit]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.save
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end


  def show
  end

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to user_path(current_user)
  end


  def destroy
    session.clear
    redirect_to root_url
  end

private

def user_params
  params.require(:user).permit(:email, :name, :phone_number, :password, :password_confirmation)
end

end
