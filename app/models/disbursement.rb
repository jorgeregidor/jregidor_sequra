class Disbursement < ApplicationRecord
  belongs_to :merchant, foreign_key: :merchant_reference, primary_key: :reference
  has_many :orders, foreign_key: :disbursement_reference

  validates :merchant_reference, presence: true
  validates :disbursement_date, presence: true
  validates :merchant_amount_cents, presence: true
  validates :commision_amount_cents, presence: true

  scope :by_merchant, ->(merchant_reference) {
    where(merchant_reference: merchant_reference)
  }

  scope :by_date_range, ->(first_date, last_date) {
    where(disbursement_date: first_date..last_date)
  }
end
