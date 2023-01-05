FactoryBot.define do
  factory :subscription do
    title { Faker::Subscription.plan }
    price { Faker::Commerce.price(range: 0..30.0) }
    status { Faker::Number.between(from: 0, to: 1)  }
    frequency { "monthly" }
    association :customer
  end
end
