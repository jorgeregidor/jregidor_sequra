# spec/services/daily_disbursements_service_spec.rb
require 'rails_helper'

RSpec.describe DailyDisbursementsService, type: :service do
  let(:today_date) { Date.today }
  let(:service_date) { Date.today }
  let(:merchant1) { create(:merchant, reference: 'M123', disbursement_frequency: "DAILY") }
  let(:merchant2) { create(:merchant, reference: 'M456', disbursement_frequency: "WEEKLY", disbursement_wday: today_date.wday) }
  let!(:order1) { create(:order, order_date: today_date, amount_cents: 10000, merchant_reference: merchant1.reference) }
  let!(:order2) { create(:order, order_date: today_date, amount_cents: 50000, merchant_reference: merchant1.reference) }
  let!(:order3) { create(:order, order_date: today_date, amount_cents: 20000, merchant_reference: merchant2.reference) }
  let(:service) { DailyDisbursementsService.new(date: service_date) }

  describe '#call' do
    context 'when there are merchants for date' do
      let(:disbursements_service_double) { instance_double(DisbursementsService) }

      it 'calls the DisbursementsService for each merchant with orders' do
        expect(DisbursementsService).to receive(:new).and_return(disbursements_service_double).twice
        expect(disbursements_service_double).to receive(:call).twice
        service.call
      end
    end

    it 'skips merchants without orders' do
      allow(Order).to receive(:by_merchant).with([ merchant1.reference, merchant2.reference ]).and_return([])

      expect(DisbursementsService).not_to receive(:new)

      service.call
    end

    context 'when there are no merchants for date' do
      let(:service_date) { today_date - 1.week }

      it 'does not call the DisbursementsService' do
        expect(DisbursementsService).not_to receive(:new)

        service.call
      end
    end
  end
end
