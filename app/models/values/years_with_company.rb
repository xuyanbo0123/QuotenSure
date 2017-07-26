class YearsWithCompany < ActiveRecord::Base
  has_many :policies

  def self.pairs(buyer)
    YearsWithCompany.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    YearsWithCompany.find_by_name('_1').id
  end
end
