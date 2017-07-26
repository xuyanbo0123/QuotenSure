class AddUuidToAdRequests < ActiveRecord::Migration
  def change
    add_column :ad_requests, :token, :string
    add_index :ad_requests, :token
  end
end
