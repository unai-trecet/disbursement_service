require 'rails_helper'

RSpec.describe Shopper, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:nif) }

  it { should have_many(:orders) }
end
