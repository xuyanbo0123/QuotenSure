class Credit < ActiveRecord::Base
  has_many :drivers

  def self.pairs(buyer)
    Credit.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    Credit.find_by_name('_EXCELLENT').id
  end
end
