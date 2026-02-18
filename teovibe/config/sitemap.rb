SitemapGenerator::Sitemap.default_host = "https://teovibe.com"

SitemapGenerator::Sitemap.create do
  # 정적 페이지
  add about_path, changefreq: "monthly", priority: 0.7
  add consulting_path, changefreq: "monthly", priority: 0.6
  add rankings_path, changefreq: "daily", priority: 0.7

  # 카테고리 인덱스
  add blogs_path, changefreq: "daily", priority: 0.9
  add tutorials_path, changefreq: "daily", priority: 0.9
  add free_boards_path, changefreq: "daily", priority: 0.8
  add qnas_path, changefreq: "daily", priority: 0.8
  add portfolios_path, changefreq: "weekly", priority: 0.7
  add notices_path, changefreq: "weekly", priority: 0.6

  # 스킬팩
  add skill_packs_path, changefreq: "weekly", priority: 0.8
  SkillPack.published.find_each do |skill_pack|
    add skill_pack_path(skill_pack),
      lastmod: skill_pack.updated_at,
      changefreq: "monthly",
      priority: 0.7
  end

  # 게시글
  Post.published.find_each do |post|
    add send("#{post.category}_path", post),
      lastmod: post.updated_at,
      changefreq: "weekly",
      priority: 0.8
  end
end
