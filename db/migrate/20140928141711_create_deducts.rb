class CreateDeducts < ActiveRecord::Migration
  def change
    create_table :deducts do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :deducts, :name
    add_index :deducts, :moss
  end
end
