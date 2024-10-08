class Disbursement < ApplicationRecord
  belongs_to :merchant, foreign_key: :merchant_reference, primary_key: :reference
  has_many :orders, foreign_key: :disbursement_reference

  validates :merchant_reference, presence: true
  validates :disbursement_date, presence: true
  validates :merchant_amount_cents, presence: true
  validates :commision_amount_cents, presence: true
end
