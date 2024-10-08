FactoryBot.define do
  factory :item do
    association :user
    association :post
  end
end
