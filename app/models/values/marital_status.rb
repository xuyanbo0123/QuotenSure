class MaritalStatus < ActiveRecord::Base
  has_many :drivers

  def self.pairs(buyer)
    MaritalStatus.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    MaritalStatus.find_by_name('_MARRIED').id
  end
end
