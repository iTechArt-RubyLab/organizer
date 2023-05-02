class UserReminderMailer < ApplicationMailer
  def remind_mail(booking, user)
    @user = user
    @booking = booking
    mail(to: @user.email,
         subject: 'You booked a time for the service')
  end
end
