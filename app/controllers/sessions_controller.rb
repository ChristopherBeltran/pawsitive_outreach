class SessionsController < ApplicationController

  def new
  end

  def create
      if request.env['omniauth.auth']
      @user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
      if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
      else
        render :new
      end
    elsif request.referrer.include? "admin"
        @admin = Admin.find_by(email: params[:admin][:email])
        if @admin && @admin.authenticate(params[:admin][:password])
        session[:admin_id] = @admin.id
        redirect_to admin_pets_path
        else
          flash[:notice] = "Invalid email or password. Please try again."
        render :new
        end
    else
      @user = User.find_by(email: params[:user][:email])
      if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
      else
        flash[:notice] = "Invalid email or password. Please try again."
      render :new
     end
    end
  end

  def failure
    redirect_to root_path
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    session.delete(:admin_id)
    @current_admin = nil
    flash[:notice] = "You've been successfully signed out"
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
