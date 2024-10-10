require 'rails_helper'

RSpec.describe CommisionService, type: :service do
  describe '#call' do
    context 'when the amount is less than the first limit' do
      it 'applies a 1% commission' do
        service = CommisionService.new(amount_cents: 4000)
        expect(service.call).to eq(40)
      end
    end

    context 'when the amount is between the first and second limit' do
      it 'applies a 0.95% commission' do
        service = CommisionService.new(amount_cents: 10000)
        expect(service.call).to eq(95)
      end
    end

    context 'when the amount exceeds the second limit' do
      it 'applies a 0.85% commission' do
        service = CommisionService.new(amount_cents: 40000)
        expect(service.call).to eq(340)
      end
    end
  end
end
