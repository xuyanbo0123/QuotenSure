class ChangeYearMakeModelToForeignKey < ActiveRecord::Migration
  def change
    rename_column :vehicles, :year, :year_id
    add_index :vehicles, :year_id
    remove_column :vehicles, :make
    add_column :vehicles, :make_id, :integer
    add_index :vehicles, :make_id
    remove_column :vehicles, :model
    add_column :vehicles, :model_id, :integer
    add_index :vehicles, :model_id
  end
end
