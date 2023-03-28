class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  # Confirms login user.
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_url
      flash[:danger] = "Please log in."
    end
  end

  # Confirms an admin user
  def admin_user
    unless current_user.admin?
      redirect_to root_url 
      flash[:danger] = "You're not authorized."
    end
  end
end