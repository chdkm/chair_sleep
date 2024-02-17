class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65535 }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :item_tags, through: :post_tags

  mount_uploader :image, ImageUploader

  scope :with_tag, ->(item_tag_name) { joins(:item_tags).where(item_tags: { name: item_tag_name }) }
  
  def save_with_tags(item_tag_names:)
    ActiveRecord::Base.transaction do
      self.item_tags = item_tag_names.map { |name| ItemTag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def item_tag_names
    item_tags.map(&:name).join(',')
  end
end
