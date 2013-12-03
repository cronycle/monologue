xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title Monologue::Config.site_name
    xml.description Monologue::Config.meta_description
    xml.link root_url
    xml.pubDate Time.now.to_s(:rfc822)
    xml.lastBuildDate @posts.map(&:updated_at).sort.last.updated_at.to_s(:rfc822)

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description raw(post.content)
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link Monologue::Config.site_url + post.full_url
        xml.guid Monologue::Config.site_url + post.full_url
        xml.author post.author
        for tag in post.tags
          xml.category tag.name
        end
      end
    end
  end
end