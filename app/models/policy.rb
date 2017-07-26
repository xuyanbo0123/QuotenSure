class Policy < ActiveRecord::Base
  belongs_to :lead

  belongs_to :request_coverage
  belongs_to :company
  belongs_to :is_insured
  belongs_to :years_with_company
  belongs_to :continuous_year

  validates :request_coverage_id, presence: true
  validates :is_insured_id, presence: true
  validates :company_id, presence: true, if: :is_insured?
  # validates :years_with_company_id, presence: true, if: :is_insured?
  validates :expiration_date, presence: true, if: :is_insured?
  validates :continuous_year_id, presence: true, if: :is_insured?

  def is_insured?
    self.is_insured.name == '_Yes'
  end

end