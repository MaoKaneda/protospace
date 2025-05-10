class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: 'プロトタイプを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path, notice: 'プロトタイプを削除しました'
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless @prototype.user == current_user
  end
end
