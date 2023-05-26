class AddCategoryToService < ActiveRecord::Migration[7.0]
  def change
    add_reference :services, :category, null: false, foreign_key: true
  end
end
