class Education < ActiveRecord::Base
  has_many :drivers

  def self.pairs(buyer)
    Education.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    Education.find_by_name('_BACHELORS_DEGREE').id
  end
end
