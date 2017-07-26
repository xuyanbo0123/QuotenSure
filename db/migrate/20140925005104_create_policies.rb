class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.integer :request_coverage_id
      t.boolean :is_insured
      t.integer :company_id
      t.integer :years_with
      t.integer :months_at
      t.date :expiration_date
      t.integer :years_continuous
      t.integer :months_continuous

      t.integer :lead_id

      t.timestamps
    end
    add_index :policies, :request_coverage_id
    add_index :policies, :company_id

    add_index :policies, :lead_id
  end
end
