FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@factory.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
