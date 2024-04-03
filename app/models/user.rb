class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarks_posts, through: :bookmarks, source: :post
  has_many :likes, dependent: :destroy

  def own?(object)
    id == object&.user_id
  end

  def bookmark(post)
    bookmarks_posts << post
  end

  def unbookmark(post)
    bookmarks_posts.destroy(post)
  end

  def bookmark?(post)
    bookmarks_posts.include?(post)
  end

  def like(post)
    likes_posts << post
  end

  def unlike(post)
    likes_posts.destroy(post)
  end

  def like?(post)
    likes_posts.include?(post)
  end
end
