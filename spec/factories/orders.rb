FactoryBot.define do
  factory :order do
    merchant { nil }
    shopper { nil }
    amount { "" }
    completed_at { "2022-10-19 10:43:25" }
  end
end
