class Merchant < ApplicationRecord
  validates :reference, presence: true, uniqueness: true
  validates :disbursement_frequency, presence: true

  has_many :orders, foreign_key: :merchant_reference, primary_key: :reference
end
