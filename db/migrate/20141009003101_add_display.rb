class AddDisplay < ActiveRecord::Migration
  def change
    remove_column :accident_types, :created_at
    remove_column :annual_mileages, :created_at
    remove_column :claim_types, :created_at
    remove_column :coll_deducts, :created_at
    remove_column :comp_deducts, :created_at
    remove_column :companies, :created_at
    remove_column :credits, :created_at
    remove_column :damage_types, :created_at
    remove_column :educations, :created_at
    remove_column :garage_types, :created_at
    remove_column :genders, :created_at
    remove_column :lic_statuses, :created_at
    remove_column :marital_statuses, :created_at
    remove_column :occupations, :created_at
    remove_column :owner_types, :created_at
    remove_column :relationships, :created_at
    remove_column :request_coverages, :created_at
    remove_column :residence_statuses, :created_at
    remove_column :ticket_types, :created_at
    remove_column :vehicle_uses, :created_at

    remove_column :accident_types, :updated_at
    remove_column :annual_mileages, :updated_at
    remove_column :claim_types, :updated_at
    remove_column :coll_deducts, :updated_at
    remove_column :comp_deducts, :updated_at
    remove_column :companies, :updated_at
    remove_column :credits, :updated_at
    remove_column :damage_types, :updated_at
    remove_column :educations, :updated_at
    remove_column :garage_types, :updated_at
    remove_column :genders, :updated_at
    remove_column :lic_statuses, :updated_at
    remove_column :marital_statuses, :updated_at
    remove_column :occupations, :updated_at
    remove_column :owner_types, :updated_at
    remove_column :relationships, :updated_at
    remove_column :request_coverages, :updated_at
    remove_column :residence_statuses, :updated_at
    remove_column :ticket_types, :updated_at
    remove_column :vehicle_uses, :updated_at

    add_column :accident_types, :display, :string, after: :name
    add_column :annual_mileages, :display, :string, after: :name
    add_column :claim_types, :display, :string, after: :name
    add_column :coll_deducts, :display, :string, after: :name
    add_column :comp_deducts, :display, :string, after: :name
    add_column :companies, :display, :string, after: :name
    add_column :credits, :display, :string, after: :name
    add_column :damage_types, :display, :string, after: :name
    add_column :educations, :display, :string, after: :name
    add_column :garage_types, :display, :string, after: :name
    add_column :genders, :display, :string, after: :name
    add_column :lic_statuses, :display, :string, after: :name
    add_column :marital_statuses, :display, :string, after: :name
    add_column :occupations, :display, :string, after: :name
    add_column :owner_types, :display, :string, after: :name
    add_column :relationships, :display, :string, after: :name
    add_column :request_coverages, :display, :string, after: :name
    add_column :residence_statuses, :display, :string, after: :name
    add_column :ticket_types, :display, :string, after: :name
    add_column :vehicle_uses, :display, :string, after: :name
  end
end
