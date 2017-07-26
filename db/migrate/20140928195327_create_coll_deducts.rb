class CreateCollDeducts < ActiveRecord::Migration
  def change
    create_table :coll_deducts do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :coll_deducts, :name
    add_index :coll_deducts, :moss
  end
end
