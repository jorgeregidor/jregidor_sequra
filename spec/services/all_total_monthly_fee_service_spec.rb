require 'rails_helper'

RSpec.describe AllTotalMonthlyFeeService, type: :service do
  let(:date) { Date.new(2024, 10, 1) }
  let!(:merchant1) { create(:merchant, reference: 'M123', live_on: date - 1.week) }
  let!(:merchant2) { create(:merchant, reference: 'M456', live_on: date - 1.week) }
  let(:double) { instance_double(TotalMonthlyFeeService) }


  subject { AllTotalMonthlyFeeService.new(date: date) }

  describe '#call' do
    it 'calls TotalMonthlyFeeService for each merchant' do
      expect(TotalMonthlyFeeService).to receive(:new).and_return(double).twice
      expect(double).to receive(:call).twice

      subject.call
    end
  end
end
