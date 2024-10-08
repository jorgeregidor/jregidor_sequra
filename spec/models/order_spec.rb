require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:merchant) { Merchant.create(reference: 'M001', disbursement_frequency: 'weekly', live_on: Date.today) }

  context 'validations' do
    it 'is valid with valid attributes' do
      order = Order.new(merchant_reference: merchant.reference, order_date: Date.today, custom_id: 'C001')
      expect(order).to be_valid
    end

    it 'is not valid without a merchant reference' do
      order = Order.new(merchant_reference: nil)
      expect(order).to_not be_valid
      expect(order.errors[:merchant_reference]).to include("can't be blank")
    end

    it 'is not valid without an order date' do
      order = Order.new(order_date: nil)
      expect(order).to_not be_valid
      expect(order.errors[:order_date]).to include("can't be blank")
    end

    it 'is not valid without a custom id' do
      order = Order.new(custom_id: nil)
      expect(order).to_not be_valid
      expect(order.errors[:custom_id]).to include("can't be blank")
    end
  end

  context 'associations' do
    it 'belongs to merchant' do
      association = described_class.reflect_on_association(:merchant)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to disbursement' do
      association = described_class.reflect_on_association(:disbursement)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
