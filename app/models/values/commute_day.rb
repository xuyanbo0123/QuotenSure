class CommuteDay < ActiveRecord::Base
  has_many :vehicles

  def self.pairs(buyer)
    CommuteDay.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    CommuteDay.find_by_name('_5').id
  end
end
