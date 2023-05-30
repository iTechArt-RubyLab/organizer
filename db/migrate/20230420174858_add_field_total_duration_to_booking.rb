class AddFieldTotalDurationToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :total_duration, :integer
  end
end
