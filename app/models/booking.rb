class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :service

  validates_datetime :end_at, between: '4:00pm'..'2:00am'

  validates :start_at, presence: true
  validates :service, presence: true
  # validate :end_date_after_start_date
  validate :valid_start_date
  validate :booking_time
  validate :check_the_possibility_to_book, on: :create

  private

  # def end_date_after_start_date
  #   return if end_at.blank? || start_at.blank?
  #   return unless end_at <= start_at
  #
  #   errors.add(:end_at, 'must be after the start date')
  # end

  def valid_start_date
    return unless start_at < DateTime.now

    errors.add(:start_at, "You can't choose date before today")
  end

  def booking_time

    return unless total_duration < 60 && service.name != 'Message chair'

    errors.add(:total_duration, 'The minimum booking time is 1 hour.')

  end


  def check_the_possibility_to_book
    unless Booking.where(:service_id => service_id).where('start_at <= ? AND end_at >= ?', start_at + total_duration * 60 - 1, start_at).empty?

      errors.add(:start_at, "This time is unavailable")
    end
    end

end
