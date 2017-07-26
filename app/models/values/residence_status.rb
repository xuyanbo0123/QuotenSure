class ResidenceStatus < ActiveRecord::Base
  has_many :contacts

  def self.pairs(buyer)
    ResidenceStatus.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    ResidenceStatus.find_by_name('_OWN').id
  end
end
