class Order < ApplicationRecord
  belongs_to :merchant, foreign_key: :merchant_reference, primary_key: :reference
  belongs_to :disbursement, foreign_key: :merchant_reference, optional: true

  validates :merchant_reference, presence: true
  validates :order_date, presence: true
  validates :custom_id, presence: true

  scope :by_day do |date|
    where("order_date <= ?", date)
  end
end
