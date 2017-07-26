class ChangeCarTrim < ActiveRecord::Migration
  def change
    change_column :cars, :trim_id, :integer, :null => true
  end
end