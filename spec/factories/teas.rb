FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Movies::Ghostbusters.quote }
    temperature { Faker::TvShows::GameOfThrones.quote }
    brew_time { Faker::Coffee.intensifier  }
  end
end
