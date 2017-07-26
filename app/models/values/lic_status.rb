class LicStatus < ActiveRecord::Base
  has_many :drivers

  def self.pairs(buyer)
    LicStatus.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    LicStatus.find_by_name('_ACTIVE').id
  end
end
