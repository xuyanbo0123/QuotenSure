class ChangeIpNumberFromIntToInt64 < ActiveRecord::Migration
  def change
    remove_column :ip_to_locations, :ip_to, :integer
    add_column :ip_to_locations, :ip_to, :bigint
    remove_column :ip_to_locations, :ip_from, :integer
    add_column :ip_to_locations, :ip_from, :bigint
  end
end
