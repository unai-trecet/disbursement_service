require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:merchant) }
  it { should belong_to(:shopper) }
  it { should has_one(:disbursement) }

  it { should validate_presence_of(:amount_cents) }

  it { should monetize(:amount) }
end
