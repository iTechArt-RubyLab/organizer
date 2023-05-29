FactoryBot.define do
  factory :booking do
    association :service
    association :user
    start_at { Time.zone.now.beginning_of_day + 17.hours }
    end_at { Time.zone.now.beginning_of_day + 18.hours }
  end
end
