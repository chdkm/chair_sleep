require 'rails_helper'

RSpec.describe ItemTag, type: :model do
  describe 'バリデーションのテスト' do
    subject { build(:item_tag) }  # FactoryBotを使ってテスト対象のインスタンスを生成

    it '名前が存在すること' do
      subject.name = nil
      expect(subject).to be_invalid  # nameがnilの場合、無効であることを確認
      expect(subject.errors[:name]).to include("を入力してください")  # エラーメッセージの確認
    end

    it '名前がユニークであること' do
      create(:item_tag, name: 'ユニークな名前')  # すでに存在する名前でアイテムタグを作成
      subject.name = 'ユニークな名前'
      expect(subject).to be_invalid  # 名前が重複する場合、無効であることを確認
      expect(subject.errors[:name]).to include("はすでに存在します")  # エラーメッセージの確認
    end
  end

  describe 'ransackable_attributes' do
    it 'ransackable_attributesにnameが含まれていること' do
      expect(ItemTag.ransackable_attributes).to include('name')  # ransackable_attributesメソッドがnameを含むことを確認
    end
  end

  describe 'アソシエーションのテスト' do
    it '関連するpost_tagsを持つこと' do
      item_tag = create(:item_tag)  # テスト用のアイテムタグを作成
      post_tag = create(:post_tag, item_tag: item_tag)  # アイテムタグに関連付けたポストタグを作成
      expect(item_tag.post_tags).to include(post_tag)  # アイテムタグがポストタグを含むことを確認
    end

    it '関連するpostsを持つこと' do
      item_tag = create(:item_tag)  # テスト用のアイテムタグを作成
      post = create(:post)  # テスト用のポストを作成
      create(:post_tag, item_tag: item_tag, post: post)  # アイテムタグに関連付けたポストタグを作成
      expect(item_tag.posts).to include(post)  # アイテムタグがポストを含むことを確認
    end
  end
end