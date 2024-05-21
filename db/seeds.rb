20.times do
  User.create!(name: Faker::Name.name,
              email: Faker::Internet.unique.email,
              password: "password",
              password_confirmation: "password")
end

user_ids = User.ids

20.times do |index|
  user = User.find(user_ids.sample)
  user.posts.create!(
    title: "タイトル#{index}",
    content: "本文#{index}",
    prepare: "仮眠準備#{index}",
    care: "仮眠後#{index}"
  )
end