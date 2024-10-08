FactoryBot.define do
  factory :user_setting do
    association :user
    line_notification { true }
  end
end
