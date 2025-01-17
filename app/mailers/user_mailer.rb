class UserMailer < ApplicationMailer

  def account_activation user
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def users_information users
    @users = users
    mail to: "hoangph030898@gmail.com", subject: "All users"
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end
