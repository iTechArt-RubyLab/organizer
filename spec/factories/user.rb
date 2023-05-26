FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "User#{i}" }
    sequence(:email) do |i|
      "user#{i}@example.com"
    end
    phone { '+37529123-45-67' }
    role { user }
  end
end
