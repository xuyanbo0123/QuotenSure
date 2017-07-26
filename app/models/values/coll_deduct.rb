class CollDeduct < ActiveRecord::Base
  has_many :vehicles

  def self.pairs(buyer)
    CollDeduct.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    CollDeduct.find_by_name('_500').id
  end
end
