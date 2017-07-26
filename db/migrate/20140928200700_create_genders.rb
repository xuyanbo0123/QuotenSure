class CreateGenders < ActiveRecord::Migration
  def change
    create_table :genders do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :genders, :name
    add_index :genders, :moss
  end
end
