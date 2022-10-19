FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    cif { Faker::Company.spanish_organisation_number }
  end
end
