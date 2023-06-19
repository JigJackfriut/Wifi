class PasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.new_password.subject
  #
  def new_password
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
