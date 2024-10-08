require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  let(:merchant) { Merchant.create(reference: 'M001', disbursement_frequency: 'weekly', live_on: Date.today) }

  context 'validations' do
    it 'is valid with valid attributes' do
      disbursement = Disbursement.new(merchant_reference: merchant.reference, disbursement_date: Date.today, merchant_amount_cents: 1000, commision_amount_cents: 100)
      expect(disbursement).to be_valid
    end

    it 'is not valid without a merchant reference' do
      disbursement = Disbursement.new(merchant_reference: nil)
      expect(disbursement).to_not be_valid
      expect(disbursement.errors[:merchant_reference]).to include("can't be blank")
    end

    it 'is not valid without a disbursement date' do
      disbursement = Disbursement.new(disbursement_date: nil)
      expect(disbursement).to_not be_valid
      expect(disbursement.errors[:disbursement_date]).to include("can't be blank")
    end

    it 'is not valid without merchant amount cents' do
      disbursement = Disbursement.new(merchant_amount_cents: nil)
      expect(disbursement).to_not be_valid
      expect(disbursement.errors[:merchant_amount_cents]).to include("can't be blank")
    end

    it 'is not valid without commision amount cents' do
      disbursement = Disbursement.new(commision_amount_cents: nil)
      expect(disbursement).to_not be_valid
      expect(disbursement.errors[:commision_amount_cents]).to include("can't be blank")
    end
  end

  context 'associations' do
    it 'belongs to merchant' do
      association = described_class.reflect_on_association(:merchant)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many orders' do
      association = described_class.reflect_on_association(:orders)
      expect(association.macro).to eq(:has_many)
    end
  end
end
