class PostsController < ApplicationController

  def show
    @post = Post.find_by_id(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    redirect_to posts_url unless is_author?
  end

  def update
    @post = Post.find_by_id(params[:id])
    redirect_to posts_url unless is_author?
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, :author_id, :sub_id)
  end
end
