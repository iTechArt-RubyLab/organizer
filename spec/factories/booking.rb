FactoryBot.define do
  factory :booking do
    association :service
    association :user
    start_at { DateTime.now.beginning_of_day.next_day + 17.hours }
    end_at { DateTime.now.beginning_of_day.next_day + 18.hours }
  end
end
