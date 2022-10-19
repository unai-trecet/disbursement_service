require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  it { should validate_presence_of(:merchant_id) }
  it { should validate_presence_of(:order_id) }
  it { should validate_presence_of(:amount_cents) }

  it { should belong_to(:merchant) }
  it { should belong_to(:order) }

  it { should monetize(:amount) }

  it { should validate_numericality_of(:amount_cents).is_greater_than(0) }
end
