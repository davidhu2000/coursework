class BandsController < ApplicationController
  before_action :check_logged_in
  before_action :get_band, only: [:show, :edit, :update, :destroy]

  def index
    @bands = Band.all
  end

  def show
    session[:return_to] ||= band_url(@band)
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:success] = ['Band created']
      redirect_to band_url(@band)
    else
      flash.now[:danger] = @band.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @band.update(band_params)
      flash[:success] = ['Band updated']
      redirect_to band_url(@band)
    else
      flash.now[:danger] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @band.destroy
      flash[:success] = ['Band deleted']
      redirect_to bands_url
    else
      flash.now[:danger] = @band.errors.full_messages
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

  def get_band
    @band = Band.find_by(id: params[:id])
  end


end
