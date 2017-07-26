class AgeLic < ActiveRecord::Base
  has_many :drivers

  def self.pairs(buyer)
    AgeLic.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # AgeLic.find_by_name('_18').id
    nil
  end
end
