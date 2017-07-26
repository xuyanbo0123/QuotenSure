class Driver < ActiveRecord::Base
  attr_accessor :duis, :accidents, :claims, :tickets

  belongs_to :lead
  belongs_to :vehicle

  belongs_to :gender
  belongs_to :marital_status
  belongs_to :relationship
  belongs_to :occupation
  belongs_to :education
  belongs_to :credit
  belongs_to :lic_status
  belongs_to :age_lic
  belongs_to :is_sr22

  validates :relationship_id, presence: true
  # validates :first_name, presence: true, length: { minimum: 2 }, format: { with: /\A(?!.*fuck).*\z/i, message: "Please input real name" }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthday, presence: true
  validates :gender_id, presence: true
  validates :marital_status_id, presence: true
  validates :occupation_id, presence: true
  validates :education_id, presence: true
  validates :credit_id, presence: true
  validates :age_lic_id, presence: true
  validates :lic_status_id, presence: true
  validates :is_sr22_id, presence: true

  scope :primary_driver, -> { where(rid: 0) }

  def prepare_incidents
    @duis = Array.new
    @accidents = Array.new
    @claims = Array.new
    @tickets = Array.new
    self.lead.incidents.each do |i|
      if i.driver_rid.equal?(self.rid)
        if i._dui?
          @duis.push(i)
        elsif i._accident?
          @accidents.push(i)
        elsif i._claim?
          @claims.push(i)
        elsif i._ticket?
          @tickets.push(i)
        end
      end
    end
  end

  def has_dui
    @duis.count > 0
  end

  def has_accident
    @accidents.count > 0
  end

  def has_claim
    @claims.count > 0
  end

  def has_ticket
    @tickets.count > 0
  end

end