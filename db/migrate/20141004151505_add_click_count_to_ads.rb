class AddClickCountToAds < ActiveRecord::Migration
  def change
    add_column :ads, :click_count, :integer, after: :display_link, default: 0
  end
end
