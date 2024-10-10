require 'rails_helper'

RSpec.describe TotalMonthlyFeeService, type: :service do
  let(:merchant) { create(:merchant, reference: 'M123', minimum_monthly_fee_cents: 5000) }
  let(:date) { Date.new(2024, 10, 1) }
  let(:service) { TotalMonthlyFeeService.new(merchant, date) }

  describe '#call' do
    context 'when there are disbursements for the merchant' do
      before do
        create(:disbursement, merchant_reference: merchant.reference, commision_amount_cents: 6000, disbursement_date: date)
        create(:disbursement, merchant_reference: merchant.reference, commision_amount_cents: 4000, disbursement_date: date)
      end

      it 'creates a TotalMonthlyFee record' do
        expect { service.call }.to change { TotalMonthlyFee.count }.by(1)
      end

      it 'calculates the total commission amount correctly' do
        service.call
        total_fee = TotalMonthlyFee.last
        expect(total_fee.amount_cents).to eq(10000)
      end

      it 'sets reached to true if total commission meets the minimum monthly fee' do
        service.call
        total_fee = TotalMonthlyFee.last
        expect(total_fee.reached).to be true
      end
    end

    context 'when there are no disbursements for the merchant' do
      it 'creates a TotalMonthlyFee record with zero amount' do
        expect { service.call }.to change { TotalMonthlyFee.count }.by(1)
        total_fee = TotalMonthlyFee.last
        expect(total_fee.amount_cents).to eq(0)
        expect(total_fee.reached).to be false
      end
    end
  end
end
