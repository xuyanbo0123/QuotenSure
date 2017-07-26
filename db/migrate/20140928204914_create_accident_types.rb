class CreateAccidentTypes < ActiveRecord::Migration
  def change
    create_table :accident_types do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :accident_types, :name
    add_index :accident_types, :moss
  end
end
