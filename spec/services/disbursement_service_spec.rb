require 'rails_helper'

RSpec.describe DisbursementsService, type: :service do
  let(:merchant) { create(:merchant, reference: 'M123') }
  let(:today_date) { Date.today }
  let(:orders) { [
    create(:order, order_date: today_date, amount_cents: 10000, merchant_reference: merchant.reference),
    create(:order, order_date: today_date, amount_cents: 50000, merchant_reference: merchant.reference)
  ] }
  let(:date) { Date.today }
  let(:disbursement_service) { DisbursementsService.new(date: date, merchant: merchant, orders: orders) }

  describe '#call' do
    it 'creates a new disbursement with correct amounts' do
      expect { disbursement_service.call }.to change { Disbursement.count }.by(1)

      disbursement = Disbursement.last
      expect(disbursement.merchant_reference).to eq('M123')
      expect(disbursement.merchant_amount_cents).to eq(59480)
      expect(disbursement.commision_amount_cents).to eq(520)
      expect(disbursement.disbursement_date).to eq(date)
    end

    it 'updates the orders with the disbursement reference' do
      disbursement_service.call

      disbursement = Disbursement.last
      orders.each do |order|
        expect(order.reload.disbursement_reference).to eq(disbursement.id)
      end
    end
  end
end
