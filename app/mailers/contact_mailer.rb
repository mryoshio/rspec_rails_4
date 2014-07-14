class ContactMailer < ActionMailer::Base
  default from: 'noreply@example.com'

  def welcome_email(contact)
    @url = 'https://bufferapp.com/'
    @contact = contact
    mail(to: contact.email, subject: 'welcome to my site.')
  end
end
