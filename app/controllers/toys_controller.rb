class ToysController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: :destroy
  before_action :correct_user, only: [:edit]

  def index
    @toys = Toy.includes(:user, images_attachments: :blob).paginate(page: params[:page])
    # render json: @toys.as_json(include: :images)
  end

  def show
    @toy = Toy.includes(images_attachments: :blob).find(params[:id])
  end

  def new
    @toy = current_user.toys.build
  end

  def create
    @toy = current_user.toys.build(toy_params)
  
    if @toy.save
      flash[:success] = "Toy saved successfully."
      redirect_to toys_url
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @toy = Toy.find(params[:id])
  end

  def update
    @toy = Toy.find(params[:id])

    if @toy.update(toy_params)
      flash[:success] = "Toy updated successfully."
      redirect_to @toy
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    Toy.find(params[:id]).destroy
    flash[:success] = "Toy deleted successfully."
    redirect_to toys_url
  end

  private

  def toy_params
    params.require(:toy).permit(:name, :description, :user_id, images: [])
  end
  
  def correct_user
    @toy = current_user.toys.find_by(id: params[:id])
    redirect_to root_url if @toys.nil?
  end
  
end
