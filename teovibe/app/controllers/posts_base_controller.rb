class PostsBaseController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_post!, only: %i[edit update destroy]

  layout "application"

  def index
    @category = category
    @posts = Post.where(category: category).published.pinned_first.includes(:user)
    @pagy, @posts = pagy(:offset, @posts, limit: 12)
    render "posts/index"
  end

  def show
    @comments = @post.comments.includes(:user).where(parent_id: nil).order(created_at: :asc)
    render "posts/show"
  end

  def new
    @post = Post.new(category: category)
    render "posts/new"
  end

  def create
    @post = Current.user.posts.build(post_params.merge(category: category, status: :published))
    if @post.save
      redirect_to url_for_post(@post), notice: "글이 작성되었습니다."
    else
      render "posts/new", status: :unprocessable_entity
    end
  end

  def edit
    render "posts/edit"
  end

  def update
    if @post.update(post_params)
      redirect_to url_for_post(@post), notice: "글이 수정되었습니다."
    else
      render "posts/edit", status: :unprocessable_entity
    end
  end

  def destroy
    cat = @post.category
    @post.destroy
    redirect_to send("#{cat.pluralize}_path"), notice: "글이 삭제되었습니다.", status: :see_other
  end

  private

  def category
    raise NotImplementedError
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post!
    unless @post.user == Current.user || Current.user&.admin?
      redirect_to root_path, alert: "권한이 없습니다."
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :slug, :status, :pinned, :seo_title, :seo_description)
  end

  def url_for_post(post)
    helpers.url_for_post(post)
  end
end
