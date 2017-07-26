class ChangeAdRequestResponse < ActiveRecord::Migration
  def change
    change_column :ad_requests, :response, :text
  end
end
