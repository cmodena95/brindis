class ContactsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    authorize @contact
    # if @contact.deliver
      if params[:source] == "workshop"
        redirect_to workshops_path(Workshop.last), notice: "Mensaje enviado con exito!"
      else
        redirect_to showroom_path, notice: "Mensaje enviado con exito!"
      end
    # else
      # if params[:source] == "workshop"
      #   flash.now[:error] = 'No se pudo enviar el mensaje'
      #   render "workshops/show", status: :unprocessable_entity
      # else
      #   flash.now[:success] = 'No se pudo enviar el mensaje'
      #   render "pages/showroom", status: :unprocessable_entity
      # end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :content, :time, :order_number)
  end
end
