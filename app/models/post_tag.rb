class PostTag < ApplicationRecord
  belongs_to :item_tag
  belongs_to :post

  validates :item_tag_id, uniqueness: { scope: :post_id }
end
