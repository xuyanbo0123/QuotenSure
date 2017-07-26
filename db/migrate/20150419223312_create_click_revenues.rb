class CreateClickRevenues < ActiveRecord::Migration
  def change
    create_table :click_revenues do |t|
      t.string :source
      t.string :token
      t.integer :engagement
      t.decimal :amount
    end

    add_index :click_revenues, :source
  end
end
