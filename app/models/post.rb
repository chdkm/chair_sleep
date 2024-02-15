class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65535 }

  belongs_to :user
  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader
end
