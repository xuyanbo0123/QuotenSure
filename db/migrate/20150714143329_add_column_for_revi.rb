class AddColumnForRevi < ActiveRecord::Migration
  def change
    add_column :accident_types, :revi, :string
    add_column :age_lics, :revi, :string
    add_column :annual_mileages, :revi, :string
    add_column :claim_types, :revi, :string
    add_column :coll_deducts, :revi, :string
    add_column :commute_days, :revi, :string
    add_column :comp_deducts, :revi, :string
    add_column :companies, :revi, :string
    add_column :continuous_years, :revi, :string
    add_column :credits, :revi, :string
    add_column :damage_types, :revi, :string
    add_column :educations, :revi, :string
    add_column :garage_types, :revi, :string
    add_column :genders, :revi, :string
    add_column :is_insureds, :revi, :string
    add_column :is_sr22s, :revi, :string
    add_column :lic_statuses, :revi, :string
    add_column :marital_statuses, :revi, :string
    add_column :occupations, :revi, :string
    add_column :owner_types, :revi, :string
    add_column :relationships, :revi, :string
    add_column :request_coverages, :revi, :string
    add_column :residence_months, :revi, :string
    add_column :residence_statuses, :revi, :string
    add_column :residence_years, :revi, :string
    add_column :ticket_types, :revi, :string
    add_column :vehicle_uses, :revi, :string
    add_column :years_with_companies, :revi, :string
  end
end
