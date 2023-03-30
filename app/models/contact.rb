class Contact < MailForm::Base
  attribute :email
  attribute :content

  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :content, validate:true

  def headers
    { 
      to: "cmodena95@gmail.com", # change this to be the email you want sent to
      subject: "Nuevo email",
      from: "cmodena95@gmail.com",  # change this to be the email it is coming from
      reply_to: %("<#{email}>") 
    }
  end
end
