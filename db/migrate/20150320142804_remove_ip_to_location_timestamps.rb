class RemoveIpToLocationTimestamps < ActiveRecord::Migration
  def change
    remove_column :ip_to_locations, :created_at
    remove_column :ip_to_locations, :updated_at
  end
end
