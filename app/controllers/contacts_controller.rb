class ContactsController < ApplicationController

  def index
    @contacts = Contact.all
    render 'index.html.erb'
  end

  def show
    @contact = Contact.find(params[:id])
    render 'show.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    @contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      middle_name: params[:middle_name],
      bio: params[:bio],
      user_id: params[:user_id]
    )
    if @contact.save
      redirect_to "/contacts/#{@contact.id}"
    else
      render json: {error: @contact.errors.full_messages}, status: 422
    end
  end

  def edit
    @contact = Contact.find(params[:id])
    render 'edit.html.erb'
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.phone_number = params[:phone_number]
    @contact.middle_name = params[:middle_name]
    @contact.bio = params[:bio]
    @contact.user_id = params[:user_id]
    @contact.save
    redirect_to "/contacts/#{@contact.id}"
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to "/contacts"
  end
end
