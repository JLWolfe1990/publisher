FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    name "Test User"
    sequence :email { |n| n.to_s + "test@example.com" }
    password "please123"
  end
end
