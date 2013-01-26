require 'lanyon'

class Page < Lanyon::Template
  def article
    render
  end

  def body
    @rendered_body ||= markdown(@body)
  end

  def url
    "/" + @path.to(@path.size - 6)
  end

  def layout
    "_layouts/default.mustache"
  end

  def destination_path
    "#{url}.html"
  end
end

class Post < Lanyon::Template
  attr_accessor :year, :month, :day, :permalink

  def initialize(path, *args)
    super
    match, @year, @month, @day, @permalink = *path.match(/(\d\d\d\d)-(\d(?:\d)?)-(\d(?:\d)?)-([^\.]*)/)
  end

  def date_url
    "/#{year}/#{month}"
  end

  def article
    render
  end

  def body
    @rendered_body ||= markdown(@body)
  end

  def date
    Date.new(year.to_i, month.to_i, day.to_i)
  end

  def date_xml
    date.xmlschema
  end

  def date_ymd
    date.strftime("%Y-%m-%d")
  end

  def short_date
    result = date.day.ordinalize + date.strftime(" %B %Y")
    date.day < 10 ? " #{result}" : result.to_s
  end

  def url
    "/#{year}/#{month}/#{permalink}"
  end

  def destination_path
    "#{url}.html"
  end

  def layout
    "_layouts/post.mustache"
  end

  def related_posts
    other_posts = site.posts - [self]
    related_posts = other_posts.select {|post| (post.tags & self.tags).size > 0}
    related_posts = related_posts.sort_by {|post| (post.tags & self.tags).size }.reverse.take(5)
  end
end

