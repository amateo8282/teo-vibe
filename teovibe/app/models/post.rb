class Post < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_rich_text :body

  enum :category, { blog: 0, tutorial: 1, free_board: 2, qna: 3, portfolio: 4, notice: 5 }
  enum :status, { draft: 0, published: 1 }

  validates :title, presence: true, length: { maximum: 200 }
  validates :slug, uniqueness: true, allow_blank: true

  after_create :award_points

  scope :published, -> { where(status: :published) }
  scope :pinned_first, -> { order(pinned: :desc, created_at: :desc) }

  before_save :generate_slug, if: -> { slug.blank? && title.present? }

  # 카테고리에 맞는 라우트 키 반환
  def route_key
    case category
    when "blog" then [:blog, self]
    when "tutorial" then [:tutorial, self]
    when "free_board" then [:free_board, self]
    when "qna" then [:qna, self]
    when "portfolio" then [:portfolio, self]
    when "notice" then [:notice, self]
    else [:post, self]
    end
  end

  # 카테고리 한글 이름
  def category_name
    {
      "blog" => "블로그",
      "tutorial" => "튜토리얼",
      "free_board" => "자유게시판",
      "qna" => "Q&A",
      "portfolio" => "포트폴리오",
      "notice" => "공지사항"
    }[category]
  end

  def liked_by?(user)
    return false unless user
    likes.exists?(user: user)
  end

  private

  def award_points
    PointService.award(:post_created, user: user, pointable: self)
  end

  def generate_slug
    base = "#{id || Post.maximum(:id).to_i + 1}-#{title.parameterize}"
    # 한글 제목인 경우 ID 기반 slug 생성
    base = "post-#{id || Post.maximum(:id).to_i + 1}" if base == "#{id || Post.maximum(:id).to_i + 1}-"
    self.slug = base
  end
end
