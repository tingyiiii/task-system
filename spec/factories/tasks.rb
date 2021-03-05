FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    priority { ["low", "medium", "high"].sample }
    status { ["pending", "processing", "completed"].sample }
    start_time { Time.now }
    end_time{ Faker::Time.forward }
  end
end