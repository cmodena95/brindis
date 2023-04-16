class ContactFormController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @mail = params[:contact_form][:mail]
    @contact = params[:contact_form][:contact]

    # Perform any necessary actions with the form data
    flash[:success] = "Your message has been sent successfully."
    redirect_to :root
  end
end
