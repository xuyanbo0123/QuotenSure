class ClaimType < ActiveRecord::Base
  has_many :incidents

  def self.pairs(buyer)
    ClaimType.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # ClaimType.find_by_name('_VEHICLE_HIT_ANIMAL').id
    nil
  end
end
