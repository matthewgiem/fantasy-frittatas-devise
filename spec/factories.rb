FactoryGirl.define do
  factory :user do
    email('new@gmail.com')
    password('password')
  end
end
