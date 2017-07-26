class ResidenceYear < ActiveRecord::Base
  has_many :contacts

  def self.pairs(buyer)
    ResidenceYear.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    ResidenceYear.find_by_name('_5').id
  end
end
