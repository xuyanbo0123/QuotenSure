class ChangeAds < ActiveRecord::Migration
  def change
    change_column :ads, :header, :text
    change_column :ads, :content, :text
    change_column :ads, :logo_link, :text
    change_column :ads, :click_link, :text
    change_column :ads, :display_link, :text
  end
end
