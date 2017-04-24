FactoryGirl.define do
  factory :article do
    user
    headline 'Factory Title'
    description 'Factory Description'
    body 'Factory Body'
  end
end
