class CreateCommuteDays < ActiveRecord::Migration
  def change
    create_table :commute_days do |t|
      t.string :name
      t.string :moss
      t.string :display
      t.boolean :is_display
    end
    add_index :commute_days, :name
    add_index :commute_days, :moss
  end
end
