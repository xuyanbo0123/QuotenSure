class Incident < ActiveRecord::Base
  belongs_to :lead

  belongs_to :accident_type
  belongs_to :claim_type
  belongs_to :ticket_type
  belongs_to :damage_type

  enum incident_type_id: [:_ticket, :_claim, :_accident, :_dui]

  validates :incident_type_id, presence: true
  validates :year, presence: true, inclusion: {:in => Date.today.year.to_i-4..Date.today.year.to_i}
  validates :month, presence: true, inclusion: {:in => 1..12}
  validates :ticket_type_id, presence: true, if: :is_ticket?
  validates :state, presence: true, if: :is_dui?
  validates :accident_type_id, presence: true, if: :is_accident?
  validates :claim_type_id, presence: true, if: :is_claim?
  validates :damage_type_id, presence: true, if: [:is_accident?, :is_claim?]
  validates :at_fault, presence: true, if: [:is_accident?, :is_claim?]
  validates :paid_amount, presence: true, if: [:is_accident?, :is_claim?]

  def is_accident?
    self._accident?
  end

  def is_claim?
    self._claim?
  end

  def is_ticket?
    self._ticket?
  end

  def is_dui?
    self._dui?
  end

  def self.pairs
    [['Ticket', '_ticket'], ['Claim', '_claim'], ['Accident', '_accident'], ['DUI', '_dui']]
  end

  def self.selected_id
    nil
  end

  def self.at_fault_pairs
    [['Yes', true], ['No', false]]
  end

  def self.at_fault_selected_id
    false
  end

end
