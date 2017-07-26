class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :credits, :name
    add_index :credits, :moss
  end
end