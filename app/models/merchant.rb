class Merchant < ApplicationRecord
  has_many :orders, foreign_key: :merchant_reference, primary_key: :reference

  validates :reference, presence: true, uniqueness: true
  validates :disbursement_frequency, presence: true

  class DisbursementFrequency
    WEEKLY = "WEEKLY".freeze
    DAILY = "DAILY".freeze
  end

  scope :daily, -> { where(disbursement_frequency: DisbursementFrequency::DAILY) }

  scope :weekly, -> { where(disbursement_frequency: DisbursementFrequency::WEEKLY) }

  scope :weekly_by_wday, ->(wday) {
    where(disbursement_frequency: DisbursementFrequency::WEEKLY)
    .where(disbursement_wday: wday)
  }

  scope :by_live_on_before, ->(date) { where("live_on <= ?", date) }
end
