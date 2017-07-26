class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :moss_code
      t.string :moss

      t.timestamps null: false
    end
    add_index :companies, :name
    add_index :companies, :moss_code
    add_index :companies, :moss
  end
end