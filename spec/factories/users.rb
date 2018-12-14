FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "jdoe#{n}" }
    name { "John Doe" }
    url { "http://example.com/john" }
    avatar_url { "http://example.com/avatar/john.png" }
    provider { "github" }
  end
end
