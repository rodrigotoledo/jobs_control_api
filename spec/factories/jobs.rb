FactoryBot.define do
  factory :job do
    user { create(:user) }
    title { Faker::Job.title }
    description { Faker::Lorem.paragraph }
    status { 'open' }
    salary { Faker::Number.number(digits: 6) }
    location { Faker::Address.city }
    company { Faker::Company.name }
    requirements { Faker::Lorem.paragraph }
    responsibilities { Faker::Lorem.paragraph }
    category { "Sales"}
    job_type { 'full_time' }

    trait :part_time do
      job_type { 'part_time' }
    end

    trait :temporary do
      job_type { 'temporary' }
    end

    trait :closed do
      status { 'closed' }
    end

    trait :open do
      status { 'open' }
    end
  end
end
