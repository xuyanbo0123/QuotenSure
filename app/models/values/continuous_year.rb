class ContinuousYear < ActiveRecord::Base
  has_many :policies

  def self.pairs(buyer)
    ContinuousYear.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    ContinuousYear.find_by_name('_1').id
  end
end
