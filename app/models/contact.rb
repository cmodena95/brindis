class Contact < MailForm::Base
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :content, validate: true
  attribute :order_number, validate: true
  attribute :time, validate: true
  attribute :nickname, captcha: true

  def headers
    { 
      to: "itscamilla@hotmail.com", # change this to be the email you want sent to
      subject: "Nuevo email",
      from: "#{email}",  # change this to be the email it is coming from
      reply_to: %("<#{email}>") 
    }
  end
end
