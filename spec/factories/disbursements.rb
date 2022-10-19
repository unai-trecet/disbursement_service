FactoryBot.define do
  factory :disbursement do
    shopper { nil }
    order { nil }
    amount { "" }
    completed_at { "2022-10-19 10:48:33" }
  end
end
