class CreateMaritalStatuses < ActiveRecord::Migration
  def change
    create_table :marital_statuses do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :marital_statuses, :name
    add_index :marital_statuses, :moss
  end
end