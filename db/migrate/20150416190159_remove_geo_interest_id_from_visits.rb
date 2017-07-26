class RemoveGeoInterestIdFromVisits < ActiveRecord::Migration
  def change
    remove_column :visits, :geo_interest_id
  end
end
