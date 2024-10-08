FactoryBot.define do
  factory :comment do
    content { "ナイスポスト" } 
    association :user
    association :post
  end
end
