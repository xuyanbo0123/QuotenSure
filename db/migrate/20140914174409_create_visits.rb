class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :uuid
      t.string :ip
      t.string :browser
      t.string :device
      t.string :gclid
      t.integer :conversion, default: 0

      t.timestamps
    end
  end
end
