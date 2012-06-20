require 'lanyon'

class MainIndex < Lanyon::Template
  def url
    "/"
  end

  def title
    "Tom Ward's blog"
  end

  def description
    "Personal blog of Tom Ward, in which he writes about ruby, rails and web development, as well as other random ephemera"
  end

  def layout
    "_layouts/default.mustache"
  end

  def write_to(destination)
    posts = site.posts.reverse.take(6)
    push_context posts: posts do
      destination.write('index.html', render_page(context))
    end
  end
end