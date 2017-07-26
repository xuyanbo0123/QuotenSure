class CreateLeadRevenues < ActiveRecord::Migration
  def change
    create_table :lead_revenues do |t|
      t.string :source
      t.string :token
      t.string :status
      t.decimal :amount

    end
    add_index :lead_revenues, :source
  end
end
