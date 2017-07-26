class RequestCoverage < ActiveRecord::Base
  has_many :policies

  def self.pairs(buyer)
    RequestCoverage.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    RequestCoverage.find_by_name('_STANDARD_PROTECTION').id
  end
end
