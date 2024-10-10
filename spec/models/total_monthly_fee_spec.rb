require 'rails_helper'

RSpec.describe TotalMonthlyFee, type: :model do
  let(:merchant) { Merchant.create(reference: 'M001', disbursement_frequency: 'weekly', live_on: Date.today) }


  describe 'validations' do
    it 'is valid with valid attributes' do
      total_monthly_fee = TotalMonthlyFee.new(
        merchant_reference: merchant.reference,
        date: Date.today,
        amount_cents: 1000,
        reached: true
      )
      expect(total_monthly_fee).to be_valid
    end

    it 'is not valid without a date' do
      total_monthly_fee = TotalMonthlyFee.new(
        merchant_reference: merchant.reference,
        amount_cents: 1000,
        reached: true
      )
      expect(total_monthly_fee).not_to be_valid
      expect(total_monthly_fee.errors[:date]).to include("can't be blank")
    end
  end
end
