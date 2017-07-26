class ResidenceMonth < ActiveRecord::Base
  has_many :contacts

  def self.pairs(buyer)
    ResidenceMonth.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    ResidenceMonth.find_by_name('_0').id
  end
end
