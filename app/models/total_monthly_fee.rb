class TotalMonthlyFee < ApplicationRecord
  belongs_to :merchant, foreign_key: :merchant_reference, primary_key: :reference

  validates :date, presence: true
  validates :amount_cents, presence: true
end
