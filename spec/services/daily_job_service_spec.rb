require 'rails_helper'

RSpec.describe DailyJobService, type: :service do
  let(:date) { Date.new(2024, 10, 1) }
  let(:service) { DailyJobService.new(date: date) }
  let(:double_daily_disbursement_service) { instance_double(DailyDisbursementsService) }
  let(:double_all_total_monthly_fee_service) { instance_double(AllTotalMonthlyFeeService) }

  describe '#call' do
    context 'when the date is the first of the month' do
      it 'calls DailyDisbursementsService and AllTotalMonthlyFeeService' do
        expect(DailyDisbursementsService).to receive(:new)
          .and_return(double_daily_disbursement_service)
        expect(double_daily_disbursement_service).to receive(:call)

        expect(AllTotalMonthlyFeeService).to receive(:new)
          .and_return(double_all_total_monthly_fee_service)
        expect(double_all_total_monthly_fee_service).to receive(:call)

        service.call
      end
    end
  end
end
