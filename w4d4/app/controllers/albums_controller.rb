class AlbumsController < ApplicationController
  before_action :check_logged_in
  before_action :get_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
  end

  def show
  end

  def edit
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:success] = ['Album created']
      redirect_to album_url(@album)
    else
      flash.now[:danger] = @album.errors.full_messages
      render :new
    end
  end

  def update
    if @album.update(band_params)
      flash[:success] = ['Album updated']
      redirect_to album_url(@album)
    else
      flash.now[:danger] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @album.destroy
      flash[:success] = ['Album deleted']
      redirect_to band_url(@album.band)
    else
      flash.now[:danger] = @album.errors.full_messages
      render :show
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :edition)
  end

  def get_album
    @album = Album.find_by(id: params[:id])
  end
end
