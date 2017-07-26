class CreateResidenceStatuses < ActiveRecord::Migration
  def change
    create_table :residence_statuses do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :residence_statuses, :name
    add_index :residence_statuses, :moss
  end
end
