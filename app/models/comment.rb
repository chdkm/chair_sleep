class Comment < ApplicationRecord
  validates :content , presence: true, length: { maximum: 65535 }

  belongs_to :user
  belongs_to :post
end
