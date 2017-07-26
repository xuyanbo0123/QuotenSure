class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :educations, :name
    add_index :educations, :moss
  end
end
