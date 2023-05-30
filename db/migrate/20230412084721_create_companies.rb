class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.text :description

      t.timestamps
    end
  end
end
