gem 'tomafro-jekyll', '0.5.3.1'
require 'jekyll'
require 'set'
require 'fileutils'
require 'hpricot'
require 'date'



task :update_stats do  
  unless ENV["ANALYTICS_PASSWORD"]
    puts "No ANALYTICS_PASSWORD supplied so skipping stats update"
  else
  
    googleAuth = `curl https://www.google.com/accounts/ClientLogin -s \
      -d Email=tom@popdog.net \
      -d Passwd=#{ENV["ANALYTICS_PASSWORD"]} \
      -d accountType=GOOGLE \
      -d source=curl-accountFeed-v1 \
      -d service=analytics \
      | awk /Auth=.*/`.strip


    feedUri="https://www.google.com/analytics/feeds/data?start-date=2009-06-01&end-date=#{(Date.today + 1).to_s}&metrics=ga:timeOnSite&max-results=5&ids=ga:17589533&prettyprint=true"

    xml = `curl "#{feedUri}" -s --header "Authorization: GoogleLogin #{googleAuth}"`

    begin
      doc = Hpricot(xml)
      seconds = doc.at("//dxp:metric[@name='ga:timeOnSite']")['value']
      minutes = seconds.to_f / 60
      days = seconds.to_f / 60 / 60 / 24

      puts "Updating stats to show #{minutes} minutes, #{days} days"
  
      config = YAML.load_file("_config.yml")
      config["days"] = ("%10.1f" % days)
      config["minutes"] = ("%10.1f" % minutes)
      File.open("_config.yml", "w") do |out|
        YAML.dump(config, out)
      end
    rescue Object => e
      puts "Stats could not be updated:"
      p e
    end
  end
end

task :build => :update_stats do
  options = Jekyll.configuration({})
  site = Jekyll::Site.new(options)
  site.read_posts('')
  
  `rm -rf tags`
  
  tags = site.categories.keys
  if tags.size > 0
    FileUtils.mkdir_p "tags"
  
    tags.each do |tag|
      File.open "tags/#{tag}.html", "w" do |f|
        puts "Generating #{f.path}"
        f.puts %{---
layout: default
title: Posts tagged #{tag}
robots: noindex
---
{% for page in site.categories.#{tag} %}
{% assign body = page.content %}
{% include post-div.html %}
{% endfor %}
}        
      end
    end
  end
  
  `rm -rf 20*`
  
  by_year = site.posts.inject({}) do |by_year, post|
    by_year[post.date.year.to_s] ||= []
    by_year[post.date.year.to_s] << post
    by_year
  end
  
  by_year.keys.each do |year|
    File.open "#{year}.html", "w" do |f|
      puts "Generating #{f.path}"
      f.puts %{---
layout: default
title: posts from #{year}
robots: noindex
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
    FileUtils.mkdir_p "#{year_and_month.first}"
    month_name = Date.new(2008, year_and_month.last.to_i, 1).strftime("%B")
    File.open "#{year_and_month.first}/#{year_and_month.last}.html", "w" do |f|
      puts "Generating #{f.path}"
      f.puts %{---
layout: default
title: Posts from #{month_name} #{year_and_month.first}
robots: noindex 
---
{% for page in site.posts %}
  {% capture year %}{{ page.date | date: "%Y"}}{% endcapture %}
  {% capture month %}{{ page.date | date: "%m"}}{% endcapture %}
  {% if year == '#{year_and_month.first}' %}
    {% if month == '#{year_and_month.last}' %}
      {% assign body = page.content %}
      {% include post-div.html %}
    {% endif %}
  {% endif %}
{% endfor %}}
    end
  end
  
  `rm -rf _site`
  
  options = Jekyll.configuration('auto' => false)
  source      = options['source']
  destination = options['destination']
  site = Jekyll::Site.new(options)
  puts "Building site: #{source} -> #{destination}"
  site.process
  puts "Successfully generated site: #{source} -> #{destination}"
end