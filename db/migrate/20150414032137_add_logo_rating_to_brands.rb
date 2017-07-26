class AddLogoRatingToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :logo, :string
    add_column :brands, :rating, :integer
  end
end
