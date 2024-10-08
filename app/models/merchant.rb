class Merchant < ApplicationRecord
  has_many :orders, foreign_key: :merchant_reference, primary_key: :reference

  validates :reference, presence: true, uniqueness: true
  validates :disbursement_frequency, presence: true
end
