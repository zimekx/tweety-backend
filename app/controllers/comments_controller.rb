class CommentsController < ApplicationController
  def index
    @comments = Comment.all

    render json: {comments: @comments}, status: :ok
  end

  def show
    @comment = Comment.find(params[:id])

    render json: {comment: @comment}, status: :ok
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = @current_user

    if @comment.save
      render json: {comment: @comment}, status: :ok
    else
      render json: {errors: @comment.errors.messages}, status: :unprocessable_entity
    end
  end

  def destory
    @comment = Comment.find(params[:id])

    if @current_user == @comment.user #|| @current_user == @comment.event.user
      @comment.destroy

      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :event_id)
  end
end