class BookingNotificationJob
  include Sidekiq::Job
  queue_as :default

  def perform(id)

    booking = Booking.find(id)
    user = User.find(booking.user_id)
    UserReminderMailer.remind_mail(booking, user).deliver_later(wait_until: booking.remind_at)
  end
end
