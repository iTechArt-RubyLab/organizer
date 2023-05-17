require 'csv'

module GenerateCsvForUser
  extend ActiveSupport::Concern

  class_methods do
    def all_with_current_user
      date = DateTime.now
      start_date = date.beginning_of_month
      end_date = date.end_of_month
      Booking.where('start_at >= ? AND end_at <= ?', start_date, end_date)
    end

    def as_csv
      CSV.generate do |csv|
        csv << ['Service', 'Start at', 'End at', 'Duration', 'Price']
        all_with_current_user.each do |b|
          csv << [b.service.name, b.start_at, b.end_at, b.total_duration, b.total_price]
        end
      end
    end
  end
end
