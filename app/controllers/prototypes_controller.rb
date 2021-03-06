class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit]
  before_action :authenticate_user!, only: [:index, :new]
  before_action :move_to_index, only: [:edit]

  def index
    @prototypes = Prototype.all.order("created_at DESC")
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to "/prototypes/#{@prototype.id}"
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end


  private
  def prototype_params
    params.require(:prototype).permit(:name, :title, :catch_copy, :concept, :image, :text).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? && current_user.id == @prototype.user.id
      redirect_to action: :index
    end
  end
  

end