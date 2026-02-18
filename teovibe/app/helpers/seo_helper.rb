module SeoHelper
  # Article JSON-LD (게시글 상세)
  def article_json_ld(post)
    {
      "@context" => "https://schema.org",
      "@type" => "Article",
      "headline" => post.title,
      "datePublished" => post.created_at.iso8601,
      "dateModified" => post.updated_at.iso8601,
      "author" => {
        "@type" => "Person",
        "name" => post.user.nickname
      },
      "publisher" => organization_json_ld_hash
    }.to_json.html_safe
  end

  # Organization JSON-LD (루트 페이지)
  def organization_json_ld
    organization_json_ld_hash.to_json.html_safe
  end

  # FAQPage JSON-LD
  def faq_json_ld(items)
    {
      "@context" => "https://schema.org",
      "@type" => "FAQPage",
      "mainEntity" => items.map do |item|
        {
          "@type" => "Question",
          "name" => item[:question],
          "acceptedAnswer" => {
            "@type" => "Answer",
            "text" => item[:answer]
          }
        }
      end
    }.to_json.html_safe
  end

  # BreadcrumbList JSON-LD
  def breadcrumb_json_ld(items)
    {
      "@context" => "https://schema.org",
      "@type" => "BreadcrumbList",
      "itemListElement" => items.each_with_index.map do |item, i|
        entry = {
          "@type" => "ListItem",
          "position" => i + 1,
          "name" => item[:name]
        }
        entry["item"] = item[:url] if item[:url]
        entry
      end
    }.to_json.html_safe
  end

  private

  def organization_json_ld_hash
    {
      "@context" => "https://schema.org",
      "@type" => "Organization",
      "name" => "TeoVibe",
      "url" => root_url,
      "description" => "바이브코딩으로 사업을 만드는 사람들의 커뮤니티"
    }
  end
end
