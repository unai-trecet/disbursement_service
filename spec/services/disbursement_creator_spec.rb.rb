require 'rails_helper'

RSpec.describe DisbursementCreator, type: :service do
  let(:valid_order_params) do
    { amount: 50, completed_at: '01/08/2022 15:51:26' }
  end

  def define_params(params = {})
    valid_order_params.merge(params)
  end

  describe 'provided order has expected data' do
    it 'cretes a Disbursement' do
      order = create(:order, valid_order_params)

      expect do
        described_class.new(order).call
      end.to change(Disbursement, :count).from(0).to(1)

      disbursement = Disbursement.last
      expect(disbursement.merchant).to eq(order.merchant)
      expect(disbursement.order).to eq(order)
      expect(disbursement.amount.cents).to eq(48)
    end
  end

  describe "order has not enough data" do
    it 'does not create Disbursement when the amount cannot be set' do
      order = create(:order, define_params(completed_at: nil))
      expect_any_instance_of(Logger).to receive(:error)

      expect do
        described_class.new(order).call
      end.not_to change(Disbursement, :count)
    end
  end

  describe 'wrong order or no provided' do
    it 'logs error when no order is passed' do
      expect do
        described_class.new('no order').call
      end.not_to change(Disbursement, :count)
    end
  end
end
