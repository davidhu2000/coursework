class UsersController < ApplicationController
  before_action :find_user, except: [:index, :create]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: error_messages, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: error_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: @user
    else
      render json: error_messages, status: :unprocessable_entity
    end
  end

  def favorites
    user = User.find_by(id: params[:id])
    @favorite_contacts = user.contacts + user.shared_contacts
    @favorite_contacts.select!(&:favorite)
    render json: @favorite_contacts
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def error_messages
    @user.errors.full_messages
  end
end
