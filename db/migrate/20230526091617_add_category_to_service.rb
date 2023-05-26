class AddCategoryToService < ActiveRecord::Migration[7.0]
  def change
    add_reference :services, :category, foreign_key: true
  end
end
