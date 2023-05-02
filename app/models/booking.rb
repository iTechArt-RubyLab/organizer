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
  validate :check_the_possibility_to_book
  validate :working_hours

  before_validation :set_end_date, on: :create
  before_validation :total_duration_set, :total_price_set

  private

  def set_end_date
    self.end_at -= 1
  end

  def total_price_set
    self.total_price = (total_duration / service.duration) * service.price
  end

  def total_duration_set
    self.total_duration = ((self.end_at - start_at) / 60).ceil
  end

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
    return unless total_duration < service.duration

    errors.add(:end_at, "The minimum booking time is #{service.duration} minutes.")
  end

  def check_the_possibility_to_book
    id_service = Service.find_by(name: service.name).id
    return unless Booking.with_service(id_service).reservations_overlap(end_at, start_at).count >= service.quantity

    errors.add(:start_at, 'This time is unavailable. Choose another.')
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
