class DashboardController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :admin_user, only: :index
  def index
    @toys = Toy.includes(:user).paginate(page: params[:page])
    @users = User.paginate(page: params[:page])
  end
end
