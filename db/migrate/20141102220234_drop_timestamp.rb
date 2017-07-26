class DropTimestamp < ActiveRecord::Migration
  def change
    remove_column :age_lics, :created_at
    remove_column :is_sr22s, :created_at
    remove_column :is_insureds, :created_at
    remove_column :years_with_companies, :created_at
    remove_column :continuous_years, :created_at
    remove_column :residence_years, :created_at
    remove_column :residence_months, :created_at

    remove_column :age_lics, :updated_at
    remove_column :is_sr22s, :updated_at
    remove_column :is_insureds, :updated_at
    remove_column :years_with_companies, :updated_at
    remove_column :continuous_years, :updated_at
    remove_column :residence_years, :updated_at
    remove_column :residence_months, :updated_at
  end
end
