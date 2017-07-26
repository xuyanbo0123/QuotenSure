class DropDeducts < ActiveRecord::Migration
  def change
    drop_table :deducts
  end
end
