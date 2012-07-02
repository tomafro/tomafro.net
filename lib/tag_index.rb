require 'lanyon'

class TagIndex < Lanyon::Template
  def layout
    "_layouts/default.mustache"
  end

  def write_to(destination)
    tags = site.posts.compact.collect(&:tags).flatten.uniq
    tags.each do |tag|
      posts = site.posts.select {|p| p && p.tags.include?(tag) }
      push_context(
        posts: posts,
        url: "/tags/#{tag}",
        tag: tag,
        title: "Posts tagged with #{tag}"
      ) do
        destination.write "tags/#{tag}.html", render_page(context)
      end
    end
  end
end