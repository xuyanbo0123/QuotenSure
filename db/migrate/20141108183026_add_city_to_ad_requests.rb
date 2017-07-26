class AddCityToAdRequests < ActiveRecord::Migration
  def change
    add_column :ad_requests, :city, :string
  end
end
