class CreateRequestCoverages < ActiveRecord::Migration
  def change
    create_table :request_coverages do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :request_coverages, :name
    add_index :request_coverages, :moss
  end
end

