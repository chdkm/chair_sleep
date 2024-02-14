class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65535 }

  belongs_to :user

  mount_uploader :image, ImageUploader
end
