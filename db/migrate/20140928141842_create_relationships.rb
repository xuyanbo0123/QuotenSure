class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :relationships, :name
    add_index :relationships, :moss
  end
end