FactoryBot.define do
  factory :post_tag do
    association :item_tag
    association :post
  end
end
