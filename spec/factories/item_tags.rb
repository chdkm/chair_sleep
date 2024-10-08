FactoryBot.define do
  factory :item_tag do
    sequence(:name) { |n| "タグ名#{n}" }
  end
end
