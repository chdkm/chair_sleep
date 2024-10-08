require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:comment) { build(:comment, user: user, post: post, content: "This is a comment.") }

  describe "バリデーションのテスト" do
    it "コンテンツが存在すれば有効であること" do
      expect(comment).to be_valid
    end

    it "コンテンツが空であれば無効であること" do
      comment.content = nil
      expect(comment).to_not be_valid
      expect(comment.errors[:content]).to include("を入力してください")
    end

    it "コンテンツが最大文字数を超える場合無効であること" do
      comment.content = "a" * 65536
      expect(comment).to_not be_valid
      expect(comment.errors[:content]).to include("は65535文字以内で入力してください")
    end
  end

  describe "アソシエーションのテスト" do
    it "ユーザーに属していること" do
      expect(comment).to respond_to(:user)
    end

    it "ポストに属していること" do
      expect(comment).to respond_to(:post)
    end
  end

  describe "after_createコールバック" do
    let(:user_setting) { create(:user_setting, user: post.user, line_notification: true) }

    before do
      allow(LineNotificationService).to receive(:send_line_message)
    end

    it "コメントが作成された後に投稿者に通知されること" do
      expect(Rails.logger).to receive(:info).with("LINE notification will be sent to user: #{post.user.id}")
      expect(LineNotificationService).to receive(:send_line_message).with(post.user, "#{post.title}に新しいコメントが投稿されました: #{comment.content}")
      comment.save
    end

    it "LINE通知が無効な場合は通知が送信されないこと" do
      user_setting.update(line_notification: false)
      expect(Rails.logger).to receive(:info).with("LINE notification is disabled for user: #{post.user.id}")
      comment.save
    end
  end
end
