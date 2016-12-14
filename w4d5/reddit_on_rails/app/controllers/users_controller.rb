class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to subs_url
    else
      render :new
    end
  end

  # def edit
  # end
  #
  # def update
  # end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
