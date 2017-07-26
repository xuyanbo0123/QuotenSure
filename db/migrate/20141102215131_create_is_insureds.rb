class CreateIsInsureds < ActiveRecord::Migration
  def change
    create_table :is_insureds do |t|
      t.string :name
      t.string :moss
      t.string :display
      t.boolean :is_display

      t.timestamps null: true
    end
    add_index :is_insureds, :name
    add_index :is_insureds, :moss
  end
end
