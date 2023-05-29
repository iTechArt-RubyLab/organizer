class AddWorkingHoursToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :opening_time, :string
    add_column :services, :closing_time, :string
  end
end
