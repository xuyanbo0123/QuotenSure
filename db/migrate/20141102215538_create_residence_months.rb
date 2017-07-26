class CreateResidenceMonths < ActiveRecord::Migration
  def change
    create_table :residence_months do |t|
      t.string :name
      t.string :moss
      t.string :display
      t.boolean :is_display

      t.timestamps null: true
    end
    add_index :residence_months, :name
    add_index :residence_months, :moss
  end
end