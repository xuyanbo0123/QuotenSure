class Make < ActiveRecord::Base
  has_many :cars
  has_many :years, through: :cars
  has_many :models, through: :cars
  has_many :vehicles

  def as_json(params={})
    super(only: [:id, :name])
  end
end
