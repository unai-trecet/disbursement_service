FactoryBot.define do
  factory :disbursement do
    merchant
    order
    amount { Faker::Number.number(digits: 4) }
    completed_at { '2022-10-19 10:48:33' }
  end
end
