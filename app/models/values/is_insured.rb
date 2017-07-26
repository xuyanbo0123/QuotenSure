class IsInsured < ActiveRecord::Base
  has_many :policies

  def self.pairs(buyer)
    IsInsured.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # IsInsured.find_by_name('_Yes').id
    nil
  end
end
