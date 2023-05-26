FactoryBot.define do
  factory :booking do
    association :service
    association :user
        start_at { DateTime.today + 2.hours }
    end_at { DateTime.today + 3.hours }
    total_price { 40 }
    total_duration { 60 }
  end
end
