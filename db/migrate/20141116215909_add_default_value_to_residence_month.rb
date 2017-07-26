class AddDefaultValueToResidenceMonth < ActiveRecord::Migration
  def change
    change_column :contacts, :residence_month_id, :integer, :default => 1
  end
end
