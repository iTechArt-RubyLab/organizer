class AddFieldToService < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :quantity, :integer
  end
end
