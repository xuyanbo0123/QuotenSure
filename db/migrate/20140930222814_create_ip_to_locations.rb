class CreateIpToLocations < ActiveRecord::Migration
  def change
    create_table :ip_to_locations do |t|
      t.integer :ip_from, :null => false
      t.integer :ip_to, :null => false
      t.string :country_code, :null => false, :limit => 2
      t.string :country_name, :null => false, :limit => 64
      t.string :region_name, :null => false, :limit => 128
      t.string :city_name, :null => false, :limit => 128
      t.decimal :latitude, :null => false
      t.decimal :longitude, :null => false
      t.string :zip_code, :null => false, :limit => 5

      t.timestamps null: false
    end

    add_index :ip_to_locations, :zip_code
  end
end
