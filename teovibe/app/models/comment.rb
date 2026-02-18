class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 2000 }

  def liked_by?(user)
    return false unless user
    likes.exists?(user: user)
  end
end
