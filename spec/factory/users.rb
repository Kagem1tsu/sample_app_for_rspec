FactoryBot.define do
  factory :user do
    email { 'test@factory.com' }
    password { 'test' }
    password_confirmation { 'test' }
  end
end
