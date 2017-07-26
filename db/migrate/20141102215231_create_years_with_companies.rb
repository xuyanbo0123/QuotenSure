class CreateYearsWithCompanies < ActiveRecord::Migration
  def change
    create_table :years_with_companies do |t|
      t.string :name
      t.string :moss
      t.string :display
      t.boolean :is_display

      t.timestamps null: true
    end
    add_index :years_with_companies, :name
    add_index :years_with_companies, :moss
  end
end
