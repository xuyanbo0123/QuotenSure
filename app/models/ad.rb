class Ad < ActiveRecord::Base
  extend FriendlyId
  friendly_id :token

  belongs_to :ad_request

  validates :header, presence: true
  validates :content, presence: true
  validates :click_link, presence: true
  validates :logo_link, presence: true
  validates :display_link, presence: true

  def clicked
    self.click_count += 1
    self.save
  end
end
