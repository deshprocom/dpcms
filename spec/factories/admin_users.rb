FactoryGirl.define do
  factory :admin_user do
    sequence(:email) { |n| "email#{n}@deshpro.com" }
    password 'test123'
    password_confirmation 'test123'
  end
end
