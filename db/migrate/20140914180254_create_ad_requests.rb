class CreateAdRequests < ActiveRecord::Migration
  def change
    create_table :ad_requests do |t|
      t.string :zip
      t.string :state
      t.integer :sender
      t.text :response

      t.integer :visit_id

      t.timestamps
    end
    add_index :ad_requests, :visit_id
  end
end
