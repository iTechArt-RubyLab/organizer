class Booking < ApplicationRecord
  scope :reservations_overlap, ->(to, from) { where('start_at <= ? AND end_at >= ?', to, from) }
  scope :with_service, ->(id) { where('service_id = ?', id) }
  scope :this_month, lambda {
                       where('start_at >= ? AND end_at <= ?',
                             DateTime.now.beginning_of_month,
                             DateTime.now.end_of_month)
                     }

  belongs_to :user
  belongs_to :service

  validates :start_at, :end_at, presence: true
  validates :service, presence: true
  validate :end_date_after_start_date
  validate :valid_start_date
  validate :booking_time
  validate :check_the_possibility_to_book, on: :create
  validate :check_the_possibility_to_update_book, on: :update
  validate :working_hours

  before_validation :set_end_date, on: %i[create update]
  before_validation :total_duration_set, :total_price_set
  after_save :booking_notification

  def remind_at
    start_at - 1.hour
  end

  private

  def booking_notification
    BookingNotificationJob.perform_async(id)
  end

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

  def check_the_possibility_to_update_book
    id_service = Service.find_by(name: service.name).id
    return unless Booking.with_service(id_service).reservations_overlap(end_at, start_at)
                         .where.not(id:).count >= service.quantity

    errors.add(:start_at, 'This time is unavailable. Choose another.')
  end

  def working_hours
    open_time = start_at.at_beginning_of_day + service.opening_time.to_f.hour
    close_time = start_at.at_beginning_of_day + service.closing_time.to_f.hour
    open_unusual = start_at.at_beginning_of_day
    close_unusual = start_at.at_end_of_day + service.closing_time.to_f.hour

    unless start_at.between?(open_time, close_time) ||
           start_at.between?(open_time, close_unusual) ||
           start_at.between?(open_unusual, close_time)
      errors.add(:start_at, "We work from #{service.opening_time} to #{service.closing_time}")
    end

    unless end_at.between?(open_time, close_time) ||
           end_at.to_time.between?(open_time, close_unusual) ||
           end_at.to_time.between?(open_unusual, close_time)
      errors.add(:end_at, "We work from #{service.opening_time} to #{service.closing_time}")
    end
  end
end
