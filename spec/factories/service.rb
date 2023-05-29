FactoryBot.define do
  factory :service do
    sequence(:name) { |i| "Service#{i}" }
    description { 'Test description' }
    duration { 60 }
    price { 10 }
    quantity { 5 }
    status { 0 }
    association :company
    association :category
  end
end
