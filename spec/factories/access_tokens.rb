FactoryBot.define do
  factory :access_token do
    sequence(:token) { |n| "Token #{n}" }
    user
  end
end
