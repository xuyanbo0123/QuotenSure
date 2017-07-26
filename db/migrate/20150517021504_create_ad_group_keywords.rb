class CreateAdGroupKeywords < ActiveRecord::Migration
  def change
    create_table :ad_group_keywords do |t|
      t.integer :ad_group_gid, :limit => 8
      t.integer :gid, :limit => 8
      t.string :criterion_use, :default => 'BIDDABLE'
      t.string :user_status
      t.integer :first_cpc
      t.integer :top_cpc
      t.decimal :quality
      t.string :keyword
      t.string :match_type, :default => 'EXACT'

      t.timestamps null: false
    end
    add_index :ad_group_keywords, [:ad_group_gid, :gid], :unique => true
    add_index :ad_group_keywords, :ad_group_gid
  end
end
