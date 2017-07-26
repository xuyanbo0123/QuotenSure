class ChangePolicies < ActiveRecord::Migration
  def change
    rename_column :policies, :months_at, :months_with_company
    rename_column :policies, :years_with, :years_with_company_id
    add_index :policies, :years_with_company_id

    rename_column :policies, :months_continuous, :continuous_month
    rename_column :policies, :years_continuous, :continuous_year_id
    add_index :policies, :continuous_year_id

    remove_column :policies, :is_insured
    add_column :policies, :is_insured_id, :integer
    add_index :policies, :is_insured_id
  end
end
