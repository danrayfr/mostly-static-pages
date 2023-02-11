class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        log_in user
        flash[:success] = "Login successfully!"
        redirect_back_or user
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "log out successfully"
    redirect_to root_url, status: :see_other
  end
end
