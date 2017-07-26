class CreateAgeLics < ActiveRecord::Migration
  def change
    create_table :age_lics do |t|
      t.string :name
      t.string :moss
      t.string :display
      t.boolean :is_display

      t.timestamps null: true
    end
    add_index :age_lics, :name
    add_index :age_lics, :moss
  end
end