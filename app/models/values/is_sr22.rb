class IsSr22 < ActiveRecord::Base
  has_many :drivers

  def self.pairs(buyer)
    IsSr22.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    IsSr22.find_by_name('_No').id
  end
end
