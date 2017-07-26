class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.integer :gender_id
      t.integer :marital_status_id
      t.integer :relationship_id
      t.integer :occupation_id
      t.integer :education_id
      t.boolean :is_good_gpa, :default => true
      t.integer :credit_id
      t.boolean :is_bankruptcy, :default => false
      t.integer :age_lic
      t.integer :lic_status_id
      t.boolean :sr22, :default => false
      t.boolean :driver_training, :default => false

      t.integer :lead_id

      t.timestamps
    end
    add_index :drivers, :gender_id
    add_index :drivers, :marital_status_id
    add_index :drivers, :relationship_id
    add_index :drivers, :occupation_id
    add_index :drivers, :education_id
    add_index :drivers, :credit_id
    add_index :drivers, :lic_status_id

    add_index :drivers, :lead_id
  end
end
