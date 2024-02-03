FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    full_name { Faker::Name.name_with_middle }
    phone { Faker::PhoneNumber.phone_number }
    cellphone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.full_address }
  end
end
