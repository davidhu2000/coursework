class SubsController < ApplicationController
  before_action :require_current_user

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find_by_id(params[:id])
    redirect_to subs_url unless @sub
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def edit
    @sub = Sub.find_by_id(params[:id])
    redirect_to subs_url unless is_moderator?
  end

  def update
    @sub = Sub.find_by_id(params[:id])
    redirect_to subs_url unless is_moderator?
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :mod_id)
  end
end
