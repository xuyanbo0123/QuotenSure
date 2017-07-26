class CompDeduct < ActiveRecord::Base
  has_many :vehicles

  def self.pairs(buyer)
    CompDeduct.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    CompDeduct.find_by_name('_500').id
  end
end
