class Order < ApplicationRecord
  validates :merchant_reference, presence: true
  validates :order_date, presence: true
  validates :custom_id, presence: true

  belongs_to :merchant, foreign_key: :merchant_reference, primary_key: :reference
end
