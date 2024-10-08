require 'rails_helper'

RSpec.describe PostTag, type: :model do
  describe 'バリデーションのテスト' do
    let(:item_tag) { create(:item_tag) }
    let(:post) { create(:post) }
    subject { build(:post_tag, item_tag: item_tag, post: post) }  

    it 'item_tag_idはpost_idに対して一意であること' do
      create(:post_tag, item_tag: subject.item_tag, post: subject.post)
      expect(subject).to be_invalid
      expect(subject.errors[:item_tag_id]).to include('はすでに存在します')
    end

    it 'post_idが存在しない場合は無効であること' do
      subject.post_id = nil
      expect(subject).to be_invalid
      expect(subject.errors[:post]).to include("を入力してください")
    end
  end

  describe 'アソシエーションのテスト' do
    it { should belong_to(:item_tag) }
    it { should belong_to(:post) }
  end
end
