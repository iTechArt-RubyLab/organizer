FactoryBot.define do
  factory :booking do
    association :service
    association :user
    start_at { Time.new.beginning_of_day + 17.hour }
    end_at { Time.new.beginning_of_day + 18.hour }
  end
end
