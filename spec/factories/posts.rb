FactoryBot.define do
  factory :post do
    title { "タイトル例" }
    prepare { "仮眠の準備例" }
    content { "仮眠の内容例" }
    care { "仮眠後のケア例" }
    association :user  # userとの関連付け
  end
end