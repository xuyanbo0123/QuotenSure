class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :header
      t.string :content
      t.string :logo_link
      t.string :click_link
      t.string :display_link
      t.integer :ad_request_id

      t.timestamps
    end
    add_index :ads, :ad_request_id
  end
end
