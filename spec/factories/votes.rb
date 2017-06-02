FactoryGirl.define do
  factory :vote do
    user
    category 'up'
    association :voteable, factory: :article
  end
end
