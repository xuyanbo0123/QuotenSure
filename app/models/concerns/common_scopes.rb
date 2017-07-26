module CommonScopes
  extend ActiveSupport::Concern

  included do
    scope :on_day, lambda{|day| where(created_at:day.beginning_of_day..day.end_of_day)}
  end
end