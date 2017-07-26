class CreateGoogleGeos < ActiveRecord::Migration
  def change
    create_table :google_geos do |t|
      t.integer :criteria_id
      t.string :name
      t.string :canonical_name
      t.integer :parent_id
      t.string :country_code
      t.string :target_type
      t.string :status
    end
  end
end
