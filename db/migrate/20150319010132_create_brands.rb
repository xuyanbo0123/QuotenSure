class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :uuid
      t.string :name
      t.text :featured_review
      t.text :introduction

      t.timestamps
    end
  end
end
