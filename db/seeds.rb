# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  Customer.create!({first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name,
                   email: Faker::Internet.safe_email,
                   address: Faker::Address.full_address})
end

30.times do
  Tea.create!({title: Faker::Tea.variety,
              description: Faker::Movies::Ghostbusters.quote,
              temperature: Faker::TvShows::GameOfThrones.quote,
              brew_time: Faker::Coffee.intensifier})
end

teas = Tea.all
customers = Customer.all

30.times do
  Subscription.create!(
    title: Faker::Subscription.plan,
    price: Faker::Commerce.price(range: 0..30.0),
    status: Faker::Number.between(from: 0, to: 1),
    frequency: 'monthly',
    customer_id: (customers[0..4].sample).id
    )
end







