class CreateResidenceYears < ActiveRecord::Migration
  def change
    create_table :residence_years do |t|
      t.string :name
      t.string :moss
      t.string :display
      t.boolean :is_display

      t.timestamps null: true
    end
    add_index :residence_years, :name
    add_index :residence_years, :moss
  end
end
