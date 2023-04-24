class Booking < ApplicationRecord
  scope :reservations_overlap, ->(to, from) { where('start_at <= ? AND end_at >= ?', to, from) }
  scope :with_service, ->(id) { where('service_id = ?', id) }

  belongs_to :user
  belongs_to :service

  validates :start_at, presence: true
  validates :service, presence: true
  validate :end_date_after_start_date
  validate :valid_start_date
  validate :booking_time
  validate :check_the_possibility_to_book, on: :create
  validate :working_hours

  private

  def end_date_after_start_date
    return if end_at.blank? || start_at.blank?
    return unless end_at <= start_at

    errors.add(:end_at, 'must be after the start date')
  end

  def valid_start_date
    return unless start_at < DateTime.now

    errors.add(:start_at, "You can't choose date before today")
  end

  def booking_time
    total_d = ((end_at - start_at) / 60).ceil
    if total_d < 60 && service.name != 'Message chair'
      errors.add(:end_at, 'The minimum booking time is 1 hour.')
    elsif total_d < 15 && service.name == 'Message chair'
      errors.add(:end_at, 'The minimum booking time is 15 minutes.')
    end
  end

  def check_the_possibility_to_book
    if service_id == 1 && Booking.with_service(1).reservations_overlap(end_at, start_at).count >= 5 ||
       service_id == 2 && Booking.with_service(2).reservations_overlap(end_at, start_at).count >= 8 ||
       service_id != 1 && service_id != 2 && Booking.with_service(service_id).reservations_overlap(end_at, start_at).any?
      errors.add(:start_at, 'This time is unavailable. Choose another.')
    end
  end

  def working_hours
    start_day = start_at.beginning_of_day
    end_day = start_at.end_of_day
    open_hour = start_day + 16.hours
    close_hour = start_day + 2.hours
    unless start_at >= start_day && start_at <= close_hour || start_at >= open_hour && start_at <= end_day
      errors.add(:start_at, 'We work from 16 pm to 2 am')
    end

    unless ((start_at >= start_day && start_at <= close_hour) &&
            (end_at <= close_hour + 1.second && end_at >= start_day)) ||
           (start_at >= open_hour && start_at <= end_day) &&
           (end_at <= end_day + 2.hours + 1.second && end_at >= open_hour)
      errors.add(:end_at, 'We work from 16 pm to 2 am')
    end
  end
end
