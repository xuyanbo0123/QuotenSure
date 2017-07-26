class Visit < ActiveRecord::Base
  has_many :leads
  has_many :ad_requests
  has_many :ads, through: :ad_requests

  validates :uuid, presence: true

  def self.current(id, uuid)
    where(:id => id, :uuid => uuid).first
  end
end
