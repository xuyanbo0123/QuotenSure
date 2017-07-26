class Contact < ActiveRecord::Base
  belongs_to :lead

  belongs_to :residence_status
  belongs_to :residence_year
  belongs_to :residence_month

  validates :phone, presence: true, format: {with: /\A\d{10}\z/}
  validates :address1, presence: true
  validates :zip, presence: true, format: { with: /\A\d{5}\z/, message: "Please input valid zip" }
  # validates :email, presence: true, format:{ with: /\A.+@.+\..+\z/}
  validates :email, presence: true, format:{ with: /\A.+@.+\z/}
  validates :residence_status_id, presence: true
  validates :residence_year_id, presence: true
  # validates :residence_month_id, presence: true

  before_save :set_city_state

  def set_city_state
    zip_code = ZipCode.find_by_zip(self.zip)
    if zip_code.present?
      self.city = zip_code.city
      self.state = zip_code.state
    end
  end

end