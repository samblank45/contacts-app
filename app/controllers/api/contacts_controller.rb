class Api::ContactsController < ApplicationController

  def index
    @contacts = current_user.contacts
    if params[:group]
      group = Group.find_by(name: params[:group])
      @contacts = groups.contacts.where(user_id: current_user.id)
    end
    if params[:search]
      @contacts = @contacts.where("first_name iLIKE ? OR middle_name iLIKE ? OR last_name iLIKE ? OR email iLIKE ? OR bio iLIKE ? OR phone_number iLIKE?", "%#{params[:search]}%", "#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%" )
    end
    render "index.json.jb"
  end

  def create
    coordinates = Geocoder.coordinates(params[:address])
    @contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      middle_name: params[:middle_name],
      bio: params[:bio],
      longitude: coordinates[0],
      latitude: coordinates[1],
    )
    if @contact.save
      render 'show.json.jb'
    else  
      render json: {errors: @contact.errors.full_messages}, status: 422
    end
  end

  def show
    @contact = Contact.find_by(id: params[:id])
    render 'show.json.jb'
  end
  
  def update
    if params[:address]
      coordinates = Geocoder.coordinates(params[:address])
      @contact.longitude = coordinates[0]
      @contact.latitude = coordinates[1]
    end
    @contact = Contact.find_by(id: params[:id])
    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.email = params[:email] || @contact.email
    @contact.phone_number = params[:phone_number] || @contact.phone_number
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    @contact.bio = params[:bio] || @contact.bio
    if @contact.save
      render 'show.json.jb'
    else  
      render json: {errors: @contact.errors.full_messages}, status: 422
    end
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    render json: {message: "contact successfuly destroyed"}
  end

end
