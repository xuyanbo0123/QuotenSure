class TicketType < ActiveRecord::Base
  has_many :incidents

  def self.pairs(buyer)
    TicketType.where(:is_display => true).pluck(buyer, :id)
  end

  def self.selected_id
    # TicketType.find_by_name('_SPEEDING_UNDER_10_OVER').id
    nil
  end
end
