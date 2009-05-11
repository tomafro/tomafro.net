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
{% for page in site.categories.#{tag} %}
{% assign body = page.content %}
{% include post-div.html %}
{% endfor %}
}        
      end
    end
  end
  
  by_year = site.posts.inject({}) do |by_year, post|
    by_year[post.date.year.to_s] ||= []
    by_year[post.date.year.to_s] << post
    by_year
  end
  
  by_year.keys.each do |year|
    FileUtils.mkdir_p year
    File.open "#{year}/index.html", "w" do |f|
      f.puts %{---
layout: default
title: tomafro.net
---
{% for page in site.posts %}
{% capture year %}{{ page.date | date: "%Y"}}{% endcapture %}
{% if year == '#{year}' %}
{% assign body = page.content %}
{% include post-div.html %}
{% endif %}
{% endfor %}}
    end
  end
  
  by_year_and_month = site.posts.inject({}) do |result, post|
    result[[post.date.year.to_s, post.date.strftime("%m")]] ||= []
    result[[post.date.year.to_s, post.date.strftime("%m")]] << post
    result
  end
  
  by_year_and_month.keys.each do |year_and_month|
    FileUtils.mkdir_p "#{year_and_month.first}/#{year_and_month.last}"
    File.open "#{year_and_month.first}/#{year_and_month.last}/index.html", "w" do |f|
      f.puts %{---
layout: default
title: tomafro.net
---
{% for page in site.posts %}
{% capture year %}{{ page.date | date: "%Y"}}{% endcapture %}
{% capture month %}{{ page.date | date: "%m"}}{% endcapture %}
{% if year == '#{year_and_month.first}' & month = '#{year_and_month.last}'%}
{% assign body = page.content %}
{% include post-div.html %}
{% endif %}
{% endfor %}}
    end
  end
end