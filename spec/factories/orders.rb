FactoryBot.define do
  factory :order do
    merchant
    shopper
    amount { Faker::Number.number(digits: 4) }
    completed_at { nil }
  end
end
