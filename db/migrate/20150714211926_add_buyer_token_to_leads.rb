class AddBuyerTokenToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :buyer_token, :string
  end
end
