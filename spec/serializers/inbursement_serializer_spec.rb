require 'rails_helper'

RSpec.describe DisbursementSerializer, type: :serializer do
  it 'should include correct key values' do
    disbursement = create(:disbursement, amount_cents: 55)
    serializer = DisbursementSerializer.new(disbursement)

    expect(serializer.serializable_hash[:id]).to eq(disbursement.id)
    expect(serializer.serializable_hash[:amount].cents).to eq(55)
    expect(serializer.serializable_hash[:order].to_json).to eq(disbursement.order.to_json)
    expect(serializer.serializable_hash[:merchant].to_json).to eq(disbursement.merchant.to_json)
  end
end
