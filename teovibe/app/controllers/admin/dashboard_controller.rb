module Admin
  class DashboardController < BaseController
    def index
      @total_users = User.count
      @total_posts = Post.count
      @total_comments = Comment.count
      @recent_posts = Post.includes(:user).order(created_at: :desc).limit(5)
      @recent_users = User.order(created_at: :desc).limit(5)
    end
  end
end
