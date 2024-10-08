class Merchant < ApplicationRecord
  has_many :orders, foreign_key: :merchant_reference, primary_key: :reference

  validates :reference, presence: true, uniqueness: true
  validates :disbursement_frequency, presence: true

  class DisbursementFrequency
    WEEKLY = "WEEKLY"
    DAILY = "DAILY"
  end

  scope :daily do
    where(disbursement_frequency: DisbursementFrequency::DAILY)
  end

  scope :weekly do
    where(disbursement_frequency: DisbursementFrequency::WEEKLY)
  end

  scope :weekly_by_wday do |wday|
    where(disbursement_frequency: DisbursementFrequency::WEEKLY)
    .where(disbursement_wday: wday)
  end
end
