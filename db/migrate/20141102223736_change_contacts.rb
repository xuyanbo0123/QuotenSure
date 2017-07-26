class ChangeContacts < ActiveRecord::Migration
  def change
    rename_column :contacts, :years_at, :residence_year_id
    add_index :contacts, :residence_year_id

    rename_column :contacts, :months_at, :residence_month_id
    add_index :contacts, :residence_month_id
  end
end
