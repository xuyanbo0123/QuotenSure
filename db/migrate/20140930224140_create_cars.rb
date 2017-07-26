class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :year_id, :null => false
      t.integer :make_id, :null => false
      t.integer :model_id, :null => false
      t.integer :trim_id, :null => false

      t.timestamps null: false
    end
    add_index :cars, :year_id
    add_index :cars, :make_id
    add_index :cars, :model_id
    add_index :cars, :trim_id
  end
end