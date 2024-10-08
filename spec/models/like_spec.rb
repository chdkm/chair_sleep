require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:like) { build(:like, user: user, post: post) }

  describe 'バリデーションのテスト' do
    it '有効なブックマークが作成できること' do
      expect(like).to be_valid
    end

    it 'ユーザーIDがない場合、無効であること' do
      like.user = nil
      expect(like).to_not be_valid
    end

    it 'ポストIDがない場合、無効であること' do
      like.post = nil
      expect(like).to_not be_valid
    end

    it 'ユーザーIDとポストIDの組み合わせが一意であること' do
      create(:like, user: user, post: post)
      duplicate_like = build(:like, user: user, post: post)
      expect(duplicate_like).to_not be_valid
      expect(duplicate_like.errors[:user_id]).to include('はすでに存在します')
    end
  end

  describe 'アソシエーションのテスト' do
    it 'ユーザーに属していること' do
      expect(like).to respond_to(:user)
    end

    it 'ポストに属していること' do
      expect(like).to respond_to(:post)
    end
  end
end