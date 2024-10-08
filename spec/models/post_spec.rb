require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { build(:post, user: user) }

  describe 'バリデーションのテスト' do
    context 'titleのバリデーション' do
      it 'titleが存在する場合、有効であること' do
        post.title = 'タイトル'
        expect(post).to be_valid
      end

      it 'titleが空の場合、無効であること' do
        post.title = nil
        expect(post).not_to be_valid
        expect(post.errors[:title]).to include("を入力してください")
      end

      it 'titleが255文字を超える場合、無効であること' do
        post.title = 'a' * 256
        expect(post).not_to be_valid
        expect(post.errors[:title]).to include('は255文字以内で入力してください')
      end
    end

    context 'contentのバリデーション' do
      it 'contentが存在する場合、有効であること' do
        post.content = 'コンテンツ'
        expect(post).to be_valid
      end

      it 'contentが空の場合、無効であること' do
        post.content = nil
        expect(post).not_to be_valid
        expect(post.errors[:content]).to include("を入力してください")
      end

      it 'contentが65535文字を超える場合、無効であること' do
        post.content = 'a' * 65536
        expect(post).not_to be_valid
        expect(post.errors[:content]).to include('は65535文字以内で入力してください')
      end
    end

    context 'prepareとcareのバリデーション' do
      it 'prepareが空の場合、無効であること' do
        post.prepare = nil
        expect(post).not_to be_valid
        expect(post.errors[:prepare]).to include("を入力してください")
      end

      it 'careが空の場合、無効であること' do
        post.care = nil
        expect(post).not_to be_valid
        expect(post.errors[:care]).to include("を入力してください")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    it 'ユーザーに属していること' do
      expect(post.user).to eq(user)
    end

    it 'コメントを持っていること' do
      expect(Post.reflect_on_association(:comments).macro).to eq(:has_many)
    end

    it 'ブックマークを持っていること' do
      expect(Post.reflect_on_association(:bookmarks).macro).to eq(:has_many)
    end
  end

  describe '#save_with_tags' do
    it 'タグの保存が成功すること' do
      tag_names = ['タグ1', 'タグ2']
      expect(post.save_with_tags(item_tag_names: tag_names)).to eq(true)
    end

    it 'タグの保存が失敗する場合、falseを返すこと' do
      allow(post).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)
      expect(post.save_with_tags(item_tag_names: ['タグ1'])).to eq(false)
    end
  end

  describe '#item_tag_names' do
    it '関連するタグ名が正しく取得できること' do
      post.item_tags.build(name: 'タグ1')
      post.item_tags.build(name: 'タグ2')
      expect(post.item_tag_names).to eq('タグ1,タグ2')
    end
  end
end