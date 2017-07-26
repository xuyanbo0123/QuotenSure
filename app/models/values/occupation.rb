class Occupation < ActiveRecord::Base
  has_many :drivers

  def self.pairs(buyer)
    Occupation.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # Occupation.find_by_name('_BUSINESS_OWNER').id
    nil
  end
end