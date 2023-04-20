class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :service

  validates :start_at, :end_at, presence: true
  validate :end_date_after_start_date
  validate :valid_start_date
  validate :booking_time
  # validate :check_the_possibility_to_book

  private

  def end_date_after_start_date
    return if end_at.blank? || start_at.blank?
    return unless end_at <= start_at

    errors.add(:end_at, 'must be after the start date')
  end

  def valid_start_date
    return unless start_at < DateTime.now

    errors.add(:start_at, 'invalid value')
  end

  def booking_time
    time = (end_at - start_at)
    return unless time < 1.hour && service.name != 'Message chair'

    errors.add(:end_at, 'The minimum booking time is 1 hour.')

  end

  # def check_the_possibility_to_book
  #   # unless Booking.where(service_id:).where("(start_at < ? AND end_at > ?)", end_at, start_at).empty?
  #   #   errors.add(:start_at, 'Invalid period.')
  #   # end
  #   bookings = Booking.where(service_id:)
  #   bookings.each do |b|
  #     if start_at <= b.end_at && b.start_at <= end_at
  #       return errors.add(:start_at, 'Already booked')
  #     end
  #   end
  # end

end
