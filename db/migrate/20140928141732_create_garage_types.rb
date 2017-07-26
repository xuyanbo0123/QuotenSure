class CreateGarageTypes < ActiveRecord::Migration
  def change
    create_table :garage_types do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :garage_types, :name
    add_index :garage_types, :moss
  end
end
