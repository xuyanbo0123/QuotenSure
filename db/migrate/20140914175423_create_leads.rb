class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :token
      t.string :lid
      t.integer :status, default: 0
      t.integer :quote_id

      t.timestamps
    end
    add_index :leads, :quote_id
  end
end
