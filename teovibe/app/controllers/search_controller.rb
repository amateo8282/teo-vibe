class SearchController < ApplicationController
  allow_unauthenticated_access

  def index
    @query = params[:q].to_s.strip
    if @query.present?
      @posts = Post.published
        .where("title LIKE ? OR slug LIKE ?", "%#{@query}%", "%#{@query}%")
        .includes(:user)
        .order(created_at: :desc)
      @pagy, @posts = pagy(:offset, @posts, limit: 12)
    else
      @posts = Post.none
    end
  end
end
