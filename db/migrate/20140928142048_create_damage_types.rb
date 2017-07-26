class CreateDamageTypes < ActiveRecord::Migration
  def change
    create_table :damage_types do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :damage_types, :name
    add_index :damage_types, :moss
  end
end