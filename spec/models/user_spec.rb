require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'バリデーション' do
    it '名前がなければ無効であること' do
      user.name = nil
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("を入力してください")
    end

    it 'メールがなければ無効であること' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("を入力してください")
    end

    it 'パスワードが3文字未満の場合は無効であること' do
      user.password = '12'
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("は3文字以上で入力してください")
    end

    it 'メールが一意であること' do
      create(:user, email: user.email)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end

  describe '関連付け' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:bookmarks).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_one(:user_setting).dependent(:destroy) }
    it { should have_many(:authentications).dependent(:destroy) }
  end

  describe 'インスタンスメソッド' do
    let(:post) { create(:post) }

    it 'ユーザーが投稿をブックマークできること' do
      user.save
      expect { user.bookmark(post) }.to change { user.bookmarks_posts.count }.by(1)
    end

    it 'ユーザーがブックマークした投稿を外せること' do
      user.save
      user.bookmark(post)
      expect { user.unbookmark(post) }.to change { user.bookmarks_posts.count }.by(-1)
    end

    it 'ユーザーが投稿に「いいね」できること' do
      user.save
      expect { user.like(post) }.to change { user.likes_posts.count }.by(1)
    end

    it 'ユーザーが「いいね」を取り消せること' do
      user.save
      user.like(post)
      expect { user.unlike(post) }.to change { user.likes_posts.count }.by(-1)
    end

    it 'ユーザーがLINEアカウントと連携している場合、`line_user?`がtrueを返すこと' do
      create(:authentication, user: user, provider: 'line')
      expect(user.line_user?).to be true
    end
  end
end
