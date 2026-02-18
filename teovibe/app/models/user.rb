class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :connected_services, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :nickname, presence: true, length: { maximum: 30 }
  validates :email_address, presence: true, uniqueness: true

  # 역할 관리
  enum :role, { member: 0, admin: 1 }

  def admin?
    role == "admin"
  end
end
