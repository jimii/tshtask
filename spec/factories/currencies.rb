# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :currency do
    name { Faker::Name.name }
    converter { Faker::Number.number(1) }
    code { Faker::Name.name }
    buy_price { Faker::Number.number(22.22) }
    sell_price { Faker::Number.number(22.22) }
    exchange { FactoryGirl.build(:exchange) }
  end
end
