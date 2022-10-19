require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:merchant) }
  it { should belong_to(:shopper) }
  it { should have_one(:disbursement) }

  it { should validate_presence_of(:amount_cents) }
  it { should validate_presence_of(:merchant_id) }
  it { should validate_presence_of(:shopper_id) }

  it { should monetize(:amount) }

  it { should validate_numericality_of(:amount_cents).is_greater_than(0) }
end
