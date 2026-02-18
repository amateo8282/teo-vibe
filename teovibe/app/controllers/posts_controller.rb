class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Current.user.posts.build(post_params)
    if @post.save
      redirect_to polymorphic_path(@post.route_key), notice: "글이 작성되었습니다."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category, :slug, :status, :pinned, :seo_title, :seo_description)
  end
end
