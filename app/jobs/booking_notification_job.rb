class BookingNotificationJob
  include Sidekiq::Job
  queue_as :default

  def perform(id)
    @booking = Booking.find(id)
    @user = User.find(@booking.user_id)
    job_enqueue
    return unless @enqueue == false

    UserReminderMailer.remind_mail(@booking, @user).deliver_later(wait_until: @booking.remind_at)
  end

  private

  def job_enqueue
    @enqueue = false
    jobs = Sidekiq::ScheduledSet.new
    jobs.map do |job|
      next unless job.args.first['arguments'][3]['args'].first['_aj_globalid'].split('/').last.to_i == @booking.id

      job.reschedule(@booking.start_at - 1.hour)
      @enqueue = true
      break
    end
  end
end
