class ChangePaidAmoutFromDoubleToInt < ActiveRecord::Migration
  def change
    remove_column :incidents, :paid_amount
    add_column :incidents, :paid_amount, :integer
  end
end
