class UserSetting < ApplicationRecord
  belongs_to :user
  validates :line_notification, inclusion: { in: [true, false] }
end
