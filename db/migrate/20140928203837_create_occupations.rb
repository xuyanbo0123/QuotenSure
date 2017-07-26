class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :occupations, :name
    add_index :occupations, :moss
  end
end
