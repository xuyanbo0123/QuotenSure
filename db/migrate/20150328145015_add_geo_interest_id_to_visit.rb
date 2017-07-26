class AddGeoInterestIdToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :geo_interest_id, :integer
  end
end
