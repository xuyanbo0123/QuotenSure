class DamageType < ActiveRecord::Base
  has_many :accidents
  has_many :claims

  def self.pairs(buyer)
    DamageType.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # DamageType.find_by_name('_NOT_APPLICABLE').id
    nil
  end
end
