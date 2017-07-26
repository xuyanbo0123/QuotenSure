class GarageType < ActiveRecord::Base
  has_many :vehicles

  def self.pairs(buyer)
    GarageType.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # GarageType.find_by_name('_PRIVATE').id
    nil
  end
end
