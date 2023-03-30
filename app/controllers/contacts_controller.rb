class ContactsController < ApplicationController
  def create
    @workshop = Workshop.find(params[:workshop_id])
    @contact = Contact.new(params[:contact])
    @contact.request = request
    authorize @contact
    if @contact.deliver
      flash.now[:success] = 'Message sent!'
      render "workshops/show", status: :unprocessable_entity
    else
      flash.now[:error] = 'Could not send message'
      render "workshops/show", status: :unprocessable_entity
    end
  end
end
