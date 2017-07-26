class CreateAdGroupAds < ActiveRecord::Migration
  def change
    create_table :ad_group_ads do |t|
      t.integer :ad_group_gid, :limit => 8
      t.integer :gid, :limit => 8
      t.string :status
      t.string :approval_status
      t.string :headline
      t.string :description1
      t.string :description2

      t.timestamps null: false
    end
    add_index :ad_group_ads, [:ad_group_gid, :gid], :unique => true
    add_index :ad_group_ads, :ad_group_gid
  end
end
