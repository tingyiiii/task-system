FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    priority { Faker::Number.between(from: 0, to: 2) }
    status { Faker::Number.between(from: 0, to: 2) }
    start_time { Time.now }
    end_time{ Faker::Time.forward }
  end
end