class TracksController < ApplicationController
  before_action :check_logged_in
  before_action :get_band, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:success] = ['Track created']
      redirect_to track_url(@track)
    else
      flash.now[:danger] = @track.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @track.update(track_params)
      flash[:success] = ['Track updated']
      redirect_to track_url(@track)
    else
      flash.now[:danger] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @track.destroy
      flash[:success] = ['Track deleted']
      redirect_to album_url(@track.album)
    else
      flash.now[:danger] = @track.errors.full_messages
    end
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :category, :lyrics)
  end

  def get_band
    @track = Track.find_by(id: params[:id])
  end
end
