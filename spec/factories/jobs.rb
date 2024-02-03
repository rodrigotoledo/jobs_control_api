FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    user { create(:user) }
  end
end
