require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      merchant = Merchant.new(reference: 'M001', disbursement_frequency: 'weekly', live_on: Date.today)
      expect(merchant).to be_valid
    end

    it 'is not valid without a reference' do
      merchant = Merchant.new(reference: nil)
      expect(merchant).to_not be_valid
      expect(merchant.errors[:reference]).to include("can't be blank")
    end

    it 'is not valid without a disbursement frequency' do
      merchant = Merchant.new(disbursement_frequency: nil)
      expect(merchant).to_not be_valid
      expect(merchant.errors[:disbursement_frequency]).to include("can't be blank")
    end

    it 'is not valid if the reference is not unique' do
      Merchant.create(reference: 'M001', disbursement_frequency: 'weekly', live_on: Date.today)
      merchant = Merchant.new(reference: 'M001', disbursement_frequency: 'monthly', live_on: Date.today)
      expect(merchant).to_not be_valid
      expect(merchant.errors[:reference]).to include('has already been taken')
    end
  end

  context 'associations' do
    it 'has many orders' do
      association = described_class.reflect_on_association(:orders)
      expect(association.macro).to eq(:has_many)
    end
  end
end
