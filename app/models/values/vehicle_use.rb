class VehicleUse < ActiveRecord::Base
  has_many :vehicles

  def self.pairs(buyer)
    VehicleUse.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    VehicleUse.find_by_name('_COMMUTEVARIES').id
  end
end
