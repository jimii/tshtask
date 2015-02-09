class UserMailer < ActionMailer::Base

  layout "mailer"

  def send_info(email, exchange)
    @exchange = exchange
    mail(:to => "#{email} <#{email}>", :subject => "Latest news" )
  end

end
