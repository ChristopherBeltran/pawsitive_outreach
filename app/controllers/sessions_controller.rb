class SessionsController < ApplicationController

  def new
  end

  def create
    if request.referrer.include? "admin"
      @admin = Admin.find_by(email: params[:admin][:email])
      return head(:forbidden) unless @admin.authenticate(params[:admin][:password])
      session[:admin_id] = @admin.id
      redirect_to admin_pets_path
    elsif
      request.env['omniauth.auth']
      @user = User.find_or_create_from_auth_hash(env['omniauth.auth'])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @user = User.find_by(email: params[:user][:email])
      return head(:forbidden) unless @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    end
  end

  def failure
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil && session[:admin_id] = nil
    redirect_to root_path
end

private
def admin_params
  params.require(:admin).permit(:email, :password)
end

def user_params
  params.require(:user).permit(:email, :password)
end

end
