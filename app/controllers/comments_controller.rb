class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  def move_to_index
    unless user_signed_in? && current_user == @prototype.user
      redirect_to action: :index
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
