class AccidentType < ActiveRecord::Base
  has_many :incidents

  def self.pairs(buyer)
    AccidentType.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # AccidentType.find_by_name('_OTHER_VEHICLE_HIT_YOURS').id
    nil
  end
end
