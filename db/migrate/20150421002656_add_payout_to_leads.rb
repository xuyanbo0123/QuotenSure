class AddPayoutToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :payout, :decimal
  end
end
