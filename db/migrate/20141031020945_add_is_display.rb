class AddIsDisplay < ActiveRecord::Migration
  def change
    add_column :accident_types, :is_display, :boolean, after: :name
    add_column :annual_mileages, :is_display, :boolean, after: :name
    add_column :claim_types, :is_display, :boolean, after: :name
    add_column :coll_deducts, :is_display, :boolean, after: :name
    add_column :comp_deducts, :is_display, :boolean, after: :name
    add_column :companies, :is_display, :boolean, after: :name
    add_column :credits, :is_display, :boolean, after: :name
    add_column :damage_types, :is_display, :boolean, after: :name
    add_column :educations, :is_display, :boolean, after: :name
    add_column :garage_types, :is_display, :boolean, after: :name
    add_column :genders, :is_display, :boolean, after: :name
    add_column :lic_statuses, :is_display, :boolean, after: :name
    add_column :marital_statuses, :is_display, :boolean, after: :name
    add_column :occupations, :is_display, :boolean, after: :name
    add_column :owner_types, :is_display, :boolean, after: :name
    add_column :relationships, :is_display, :boolean, after: :name
    add_column :request_coverages, :is_display, :boolean, after: :name
    add_column :residence_statuses, :is_display, :boolean, after: :name
    add_column :ticket_types, :is_display, :boolean, after: :name
    add_column :vehicle_uses, :is_display, :boolean, after: :name
  end
end
