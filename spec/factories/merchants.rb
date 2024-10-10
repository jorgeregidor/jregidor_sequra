FactoryBot.define do
  factory :merchant do
    reference { Faker::Alphanumeric.unique.alpha(number: 5).downcase }
    disbursement_frequency { "DAILY" }
    email { "test1@test.com" }
    live_on { Date.today }
    minimum_monthly_fee_cents { 1000 }
  end
end
