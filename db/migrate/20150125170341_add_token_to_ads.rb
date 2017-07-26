class AddTokenToAds < ActiveRecord::Migration
  def change
    add_column :ads, :token, :string
    add_index :ads, :token
  end
end
