class Comment < ApplicationRecord
  validates :content , presence: true, length: { maximum: 65535 }

  belongs_to :user
  belongs_to :post
  after_create :notify_post_owner

  private

  def notify_post_owner
    user_setting = UserSetting.find_by(user_id: post.user.id)
    if user_setting&.line_notification
      LineNotificationService.send_line_message(post.user, "新しいコメントが投稿されました: #{content}")
    else
      Rails.logger.info "LINE notification is disabled for user: #{post.user.id}"
    end
  end
end
