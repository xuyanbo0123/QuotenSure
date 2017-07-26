class Year < ActiveRecord::Base
  has_many :cars
  has_many :makes, through: :cars
  has_many :models, through: :cars
  has_many :vehicles

  def self.pairs
    Year.all.order(name: :desc).pluck(:name, :id)
  end

  def self.selected_id
    Year.last.id
  end
end