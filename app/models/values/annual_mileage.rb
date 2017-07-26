class AnnualMileage < ActiveRecord::Base
  has_many :vehicles

  def self.pairs(buyer)
    AnnualMileage.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    AnnualMileage.find_by_name('_10000').id
  end
end
