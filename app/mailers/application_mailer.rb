class ApplicationMailer < ActionMailer::Base
  default from: Settings.gmail_username
  layout 'mailer'
end
