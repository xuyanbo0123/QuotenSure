class CreateCompDeducts < ActiveRecord::Migration
  def change
    create_table :comp_deducts do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :comp_deducts, :name
    add_index :comp_deducts, :moss
  end
end

