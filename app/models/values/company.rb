class Company < ActiveRecord::Base
  has_many :policies

  def self.pairs(buyer)
    Company.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # Company.find_by_name('_21ST_CENTURY').id
    nil
  end
end
