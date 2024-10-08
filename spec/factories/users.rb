FactoryBot.define do
  factory :user do
    name { "Superhoge" }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }

    trait :with_posts do
      after(:create) do |user|
        create_list(:post, 3, user: user)
      end
    end

    trait :with_bookmarks do
      after(:create) do |user|
        create_list(:bookmark, 2, user: user)
      end
    end

    trait :with_likes do
      after(:create) do |user|
        create_list(:like, 2, user: user)
      end
    end

    trait :line_user do
      after(:create) do |user|
        create(:authentication, user: user, provider: 'line')
      end
    end
  end
end