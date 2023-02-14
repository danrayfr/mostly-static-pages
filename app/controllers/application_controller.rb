class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private 
  
  # Confirms a logged-in user
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_url
      flash[:danger] = "Please log in."
    end
  end
  

end
