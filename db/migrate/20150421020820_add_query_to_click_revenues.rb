class AddQueryToClickRevenues < ActiveRecord::Migration
  def change
    add_column :click_revenues, :query, :integer
  end
end
