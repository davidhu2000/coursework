class ContactsController < ApplicationController
  before_action :find_contact, except: [:index, :create]

  def index
    @owned_contacts = Contact.where(user_id: params[:user_id])
    @shared_contacts = User.find_by(id: params[:user_id]).shared_contacts

    render json: {'shared contacts' => @shared_contacts,
                  'owned contacts'  => @owned_contacts}
  end

  def show
    render json: @contact
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render json: error_messages, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: error_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @contact.destroy
      render json: @contact
    else
      render json: error_messages, status: :unprocessable_entity
    end
  end

  def favorite
    @contact.favorite = true
    if @contact.save
      render json: @contact
    else
      render json: error_messages, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end

  def find_contact
    @contact = Contact.find_by(id: params[:id])
  end

  def error_messages
    @contact.errors.full_messages
  end

end
