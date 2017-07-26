class Car < ActiveRecord::Base
  belongs_to :year
  belongs_to :make
  belongs_to :model
  belongs_to :trim

  scope :unique_make_ids, ->(year_id) { where(:year_id => year_id).pluck(:make_id).uniq }
  scope :unique_model_ids, ->(year_id, make_id) { where(:year_id => year_id, :make_id => make_id).pluck(:model_id) }
end