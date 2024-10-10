FactoryBot.define do
  factory :order do
    custom_id { Faker::Alphanumeric.unique.alpha(number: 5).downcase }
    amount_cents { 10000 }
    order_date { Date.today }
    merchant
  end
end
