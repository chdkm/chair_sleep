FactoryBot.define do
  factory :authentication do
    provider { 'line' }
    uid { '1234567890' }
    user
  end
end