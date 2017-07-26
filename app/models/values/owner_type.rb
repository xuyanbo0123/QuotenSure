class OwnerType < ActiveRecord::Base
  has_many :vehicles

  def self.pairs(buyer)
    OwnerType.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    OwnerType.find_by_name('_OWNED').id
  end
end
