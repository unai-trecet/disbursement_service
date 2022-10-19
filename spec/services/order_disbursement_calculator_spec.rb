require 'rails_helper'

RSpec.describe OrderDisbursementCalculator, type: :service do
  let(:valid_params) do
    { amount: 1000, completed_at: '01/08/2022 15:51:26' }
  end

  def define_params(params = {})
    valid_params.merge(params)
  end

  describe 'order has expected data for calculation' do
    it 'returns a Money object' do
      order = create(:order, valid_params)

      result = described_class.calculate_disbursement(order)

      expect(result).to be_kind_of(Money)
      expect(result.currency.name).to eq('Euro')
    end

    context 'amount smaller than 50€' do
      it 'returns 1% fee for amounts smaller than 50€' do
        order = create(:order, define_params(amount: 15.55))

        result = described_class.calculate_disbursement(order)

        expect(result.cents).to eq(16)
      end
    end

    context 'amount between 50€ and 300€' do
      it 'returns 0.95% fee for amounts equal to 50€' do
        order = create(:order, define_params(amount: 50))

        result = described_class.calculate_disbursement(order)

        expect(result.cents).to eq(48)
      end

      it 'returns 0.95% fee for amounts between 50€ and 300€' do
        order = create(:order, define_params(amount: 99.99))

        result = described_class.calculate_disbursement(order)

        expect(result.cents).to eq(95)
      end

      it 'returns 0.95% fee for amounts equal to 300€' do
        order = create(:order, define_params(amount: 300))

        result = described_class.calculate_disbursement(order)

        expect(result.cents).to eq(285)
      end
    end

    context 'amount over 300€' do
      it 'returns 0.85% fee for amounts over 300€' do
        order = create(:order, define_params(amount: 300.1))

        result = described_class.calculate_disbursement(order)

        expect(result.cents).to eq(255)
      end

      it 'allows big amounts' do
        order = create(:order, define_params(amount: 1_000_000))

        result = described_class.calculate_disbursement(order)

        expect(result.cents).to eq(850_000)
      end
    end
  end

  describe "order's completed_at is not set" do
    it 'returns 0 cents' do
      order = create(:order, define_params(completed_at: nil))

      result = described_class.calculate_disbursement(order)

      expect(result).to be_nil
    end
  end

  describe 'wrong data provided' do
    it 'logs error when no order is passed' do
      expect_any_instance_of(Logger).to receive(:error)
      described_class.calculate_disbursement('no_order')
    end
  end
end
