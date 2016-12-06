class CommentsController < ApplicationController

  def index
    @comments = Comment.where(comments_type: type.gsub('_id','').capitalize,
                              comments_id: params[type.to_sym])

    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: error_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment.destroy
      render json: @comment
    else
      render json: error_messages, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :comments_id, :comments_type)
  end

  def type
    params.keys.select { |el| el[/.*_id/] }.first
  end

  def error_messages
    @comment.errors.full_messages
  end
end
