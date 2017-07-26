class Brand < ActiveRecord::Base
  extend FriendlyId
  friendly_id :uuid

end
