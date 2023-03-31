class ContactsController < ApplicationController
  def create
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

  private

  def contact_params
    params.require(:contact).permit(:email, :content)
  end
end
