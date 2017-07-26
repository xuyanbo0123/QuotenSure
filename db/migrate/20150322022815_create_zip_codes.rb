class CreateZipCodes < ActiveRecord::Migration
  def change
    create_table :zip_codes do |t|
      t.string :zip
      t.string :city
      t.string :state
    end
    add_index :zip_codes, :zip
  end
end
