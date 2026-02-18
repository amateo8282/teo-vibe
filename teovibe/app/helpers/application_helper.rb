module ApplicationHelper
  def url_for_post(post)
    send("#{post.category}_path", post)
  end
end
