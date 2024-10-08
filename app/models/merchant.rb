class Merchant < ApplicationRecord
  validates :reference, presence: true, uniqueness: true
  validates :disbursement_frequency, presence: true
end
