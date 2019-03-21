class UsersController < ApplicationController
  before_action :user_authenticate, only: [:show, :edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    session[:user_id] = @user.id
    flash[:notice] = "Account successfully created!"
    redirect_to user_path(@user)
  else
    render :new
      end
  end


  def show
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)
    if @user.valid?
      @user.save(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
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
