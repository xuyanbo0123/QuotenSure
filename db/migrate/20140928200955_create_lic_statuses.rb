class CreateLicStatuses < ActiveRecord::Migration
  def change
    create_table :lic_statuses do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :lic_statuses, :name
    add_index :lic_statuses, :moss
  end
end
