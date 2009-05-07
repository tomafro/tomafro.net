require 'jekyll'
require 'set'
require 'fileutils'

task :build do
  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  tags = site.posts.inject(Set.new) do |tags, post|
    ([post.data['tags']].compact.flatten).each do |t|
      tags << t
    end
  end
  if tags.size > 0
    FileUtils.mkdir_p "tags"
  
    tags.each do |tag|
      FileUtils.mkdir_p "tags/#{tag}"
      File.open "tags/#{tag}/index.html", "w" do |f|
        f.puts %{---
layout: default
title: tomafro.net
---
{% for post in site.posts %}
<div class="post">
  <div class="content">
    <h2>
      {{ post.title }}
    </h2>
    {{ post.content }}
  </div>
  <div class="meta">
    <span class="tags">
      {% for tag in post.tags %}
        <a href="/tags/{{ tag }}">{{ tag }}</a>
      {% endfor %}
    </span>
  </div>
</div>
{% endfor %}
}        
      end
    end
  end
end