class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_or_create_from_auth_hash(env["omniauth.auth"])
    session[:user_id] = @user.id
    redirect_to @user
  end

  def failure
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
end
