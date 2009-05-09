require 'jekyll'
require 'set'
require 'fileutils'

task :build do
  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  tags = site.categories.keys
  if tags.size > 0
    FileUtils.mkdir_p "tags"
  
    tags.each do |tag|
      FileUtils.mkdir_p "tags/#{tag}"
      File.open "tags/#{tag}/index.html", "w" do |f|
        f.puts %{---
layout: default
title: tomafro.net
---
{% for post in site.categories.#{tag} %}
{% include post-div.html %}
{% endfor %}
}        
      end
    end
  end
end