require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:bookmark) { build(:bookmark, user: user, post: post) }

  describe 'バリデーションのテスト' do
    it '有効なブックマークが作成できること' do
      expect(bookmark).to be_valid
    end

    it 'ユーザーIDがない場合、無効であること' do
      bookmark.user = nil
      expect(bookmark).to_not be_valid
    end

    it 'ポストIDがない場合、無効であること' do
      bookmark.post = nil
      expect(bookmark).to_not be_valid
    end

    it 'ユーザーIDとポストIDの組み合わせが一意であること' do
      create(:bookmark, user: user, post: post)
      duplicate_bookmark = build(:bookmark, user: user, post: post)
      expect(duplicate_bookmark).to_not be_valid
      expect(duplicate_bookmark.errors[:user_id]).to include('はすでに存在します')
    end
  end

  describe 'アソシエーションのテスト' do
    it 'ユーザーに属していること' do
      expect(bookmark).to respond_to(:user)
    end

    it 'ポストに属していること' do
      expect(bookmark).to respond_to(:post)
    end
  end
end