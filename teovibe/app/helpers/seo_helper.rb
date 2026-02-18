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

  # WebSite JSON-LD (검색 액션 포함)
  def website_json_ld
    {
      "@context" => "https://schema.org",
      "@type" => "WebSite",
      "name" => "TeoVibe",
      "url" => root_url,
      "description" => "바이브코딩으로 사업을 만드는 사람들의 커뮤니티",
      "potentialAction" => {
        "@type" => "SearchAction",
        "target" => {
          "@type" => "EntryPoint",
          "urlTemplate" => "#{search_url}?q={search_term_string}"
        },
        "query-input" => "required name=search_term_string"
      }
    }.to_json.html_safe
  end

  # SoftwareApplication JSON-LD (스킬팩)
  def software_application_json_ld(skill_pack)
    {
      "@context" => "https://schema.org",
      "@type" => "SoftwareApplication",
      "name" => skill_pack.title,
      "description" => skill_pack.description,
      "applicationCategory" => skill_pack.category_name,
      "offers" => {
        "@type" => "Offer",
        "price" => "0",
        "priceCurrency" => "KRW"
      },
      "operatingSystem" => "All"
    }.to_json.html_safe
  end

  # ItemList JSON-LD (목록 페이지)
  def item_list_json_ld(items, name:)
    {
      "@context" => "https://schema.org",
      "@type" => "ItemList",
      "name" => name,
      "numberOfItems" => items.size,
      "itemListElement" => items.each_with_index.map do |item, i|
        {
          "@type" => "ListItem",
          "position" => i + 1,
          "name" => item.respond_to?(:title) ? item.title : item.to_s
        }
      end
    }.to_json.html_safe
  end

  # ProfilePage JSON-LD
  def profile_page_json_ld(user)
    {
      "@context" => "https://schema.org",
      "@type" => "ProfilePage",
      "mainEntity" => {
        "@type" => "Person",
        "name" => user.nickname,
        "description" => user.bio
      }
    }.to_json.html_safe
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
