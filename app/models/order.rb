class Order < ApplicationRecord
  belongs_to :merchant, foreign_key: :merchant_reference, primary_key: :reference
  belongs_to :disbursement, foreign_key: :merchant_reference, optional: true

  validates :merchant_reference, presence: true
  validates :order_date, presence: true
  validates :custom_id, presence: true

  scope :by_ids, ->(ids) {
    where(id: ids)
  }

  scope :by_date, ->(date) {
    where("order_date <= ?", date)
  }

  scope :not_completed, -> {
    where(disbursement_reference: nil)
  }

  scope :by_merchant, ->(reference) {
    where(merchant_reference: reference)
  }
end
