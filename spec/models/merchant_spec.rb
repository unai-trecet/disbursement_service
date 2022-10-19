require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:cif) }

  it { should have_many(:orders) }
end
