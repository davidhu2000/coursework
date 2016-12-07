class CatRentalRequestsController < ApplicationController
  def new
    @ids = Cat.all.map { |cat| cat.id }
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(rental_params)

    if @request.save
      redirect_to cats_url
    else
      redirect_to new_cat_rental_request_url
    end
  end

  def update
    @request = CatRentalRequest.find_by(id: params[:id])
    @request.approve!

    redirect_to cat_url(@request.cat)
  end

  private

    def rental_params
      params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
    end

end
