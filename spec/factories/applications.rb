FactoryBot.define do
  factory :application do
    user { create(:user) }
    job { create(:job) }
    status { :pending }
    trait :approved do
      status { :approved }
    end

    trait :rejected do
      status { :rejected }
    end
  end
end
