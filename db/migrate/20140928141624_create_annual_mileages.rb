class CreateAnnualMileages < ActiveRecord::Migration
  def change
    create_table :annual_mileages do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :annual_mileages, :name
    add_index :annual_mileages, :moss
  end
end
