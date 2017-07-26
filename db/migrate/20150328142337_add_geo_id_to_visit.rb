class AddGeoIdToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :geo_id, :integer
  end
end
