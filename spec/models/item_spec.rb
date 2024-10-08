require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:item) { build(:item, user: user, post: post) }

  describe 'バリデーションのテスト' do
    it 'ユーザーIDがない場合、無効であること' do
      item.user = nil
      expect(item).to_not be_valid
    end

    it 'ポストIDがない場合、無効であること' do
      item.post = nil
      expect(item).to_not be_valid
    end
  end

  describe 'アソシエーションのテスト' do
    it 'ユーザーに属していること' do
      expect(item).to respond_to(:user)
    end

    it 'ポストに属していること' do
      expect(item).to respond_to(:post)
    end
  end
end
