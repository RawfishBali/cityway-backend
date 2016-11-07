class MessageMailer < ApplicationMailer
  def post_message(message)
    @content = message.message
    mail(to: message.email, :subject => "CityWay Message from #{message.firstname} #{message.lastname}")
   end
end
