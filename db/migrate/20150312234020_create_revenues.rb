class CreateRevenues < ActiveRecord::Migration
  def change
    create_table :revenues do |t|
      t.integer :r_type
      t.string :source
      t.string :token
      t.decimal :amount

      t.timestamps
    end
  end
end
