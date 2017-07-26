class ErrorMailer < ActionMailer::Base
  default from: "admin@quotensure.com"

  def error_email(subject, body)
    mail(to: 'admin@quotensure.com', subject: subject, body: body)
  end
end
