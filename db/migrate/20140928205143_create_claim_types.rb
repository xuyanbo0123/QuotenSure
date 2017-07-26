class CreateClaimTypes < ActiveRecord::Migration
  def change
    create_table :claim_types do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :claim_types, :name
    add_index :claim_types, :moss
  end
end
