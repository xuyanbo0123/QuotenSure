class Gender < ActiveRecord::Base
  has_many :drivers

  def self.pairs(buyer)
    Gender.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # Gender.find_by_name('_MALE').id
    nil
  end
end
