class AddDateAndLeadToClickRevenues < ActiveRecord::Migration
  def change
    add_column :click_revenues, :lead, :integer
    add_column :click_revenues, :date, :datetime
  end
end
