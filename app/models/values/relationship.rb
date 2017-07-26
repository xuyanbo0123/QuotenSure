class Relationship < ActiveRecord::Base
  has_many :drivers

  def self.pairs(buyer)
    Relationship.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # Relationship.find_by_name('_SELF').id
    nil
  end
end
