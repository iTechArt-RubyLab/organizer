FactoryBot.define do
  factory :company do
    sequence(:name) { |i| "Company#{i}" }
    description { 'Test description' }
    address { 'Test address' }
    phone { '+375291234567' }
    latitude { 53.6616761 }
    longitude { 23.7926671 }
  end
end
