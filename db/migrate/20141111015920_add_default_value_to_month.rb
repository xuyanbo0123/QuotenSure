class AddDefaultValueToMonth < ActiveRecord::Migration
  def change
    change_column :policies, :months_with_company, :integer, :default => 0
    change_column :policies, :continuous_month, :integer, :default => 0
  end
end
