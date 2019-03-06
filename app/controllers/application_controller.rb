class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :authorize_user, :current_user, :user_authenticate, :user_signed_in?, :admin_authenticate, :current_admin, :admin_signed_in?

  def user_authenticate
    redirect_to :login unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def admin_authenticate
    redirect_to :login unless admin_signed_in?
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def admin_signed_in?
    !!current_admin
  end

  def authorize_user
    if current_user != User.find_by(id: params[:user_id])
      flash[:notice] = "Sorry you don't have access."
      redirect_to user_path(current_user)
    end
  end



end
