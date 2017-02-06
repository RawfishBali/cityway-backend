class MessageMailer < ApplicationMailer
  def post_message(message)
    @content = message.message
    mail(to: message.email, :subject => "CityWay Message from #{message.firstname} #{message.lastname}")
  end

  def admin_created_notification(admin)
    @admin =  admin
    mail(to: admin.email, :subject => "Admin #{admin.email} has created")
  end
end
