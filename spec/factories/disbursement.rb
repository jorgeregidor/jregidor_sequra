FactoryBot.define do
  factory :disbursement do
    merchant_reference { merchant.reference }
    merchant_amount_cents { 6000 }
    commision_amount_cents { 6000 }
    disbursement_date { Date. today }
  end
end
