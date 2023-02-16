class ToysController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:edit, :update, :destroy]

  def index
    @toys = Toy.includes(images_attachments: :blob).paginate(page: params[:page])
    # render json: @toys.as_json(include: :images)
  end

  def show
    @toy = Toy.includes(images_attachments: :blob).find(params[:id])
  end

  def new
    @toy = current_user.toys.build
  end

  def create
    @toy = current_user.toys.new(toy_params)
    images = params[:toy][:images]

    if images
      images.each do |image|
        @toy.images.attach(image)
      end
    end
    
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
    images = params[:toy][:images]

    if images
      images.each do |image|
        @toy.images.attach(image)
      end
    end
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
  
end
