$: << File.expand_path(File.join(File.dirname(__FILE__), "lib"))

#gem 'tomafro-jekyll', '0.5.3.2'
#require 'jekyll'
require 'set'
require 'fileutils'
require 'hpricot'
require 'date'
require 'fileutils'

DESTINATION = "build"
TAGS_DIR = "site/tags"

def generate_index(posts, file, options = {})
  file.puts YAML.dump(options.merge({'layout' => 'default', 'robots' => 'noindex'}))
  file.puts "---"
  posts = posts.sort{|x, y| x.date <=> y.date }.reverse!
  output = posts.collect do |post| 
    %{{% post #{post.url} %}}
  end.join("\n")
  file.puts(output)
end

namespace :jekyll do
  task :initialize do
    gem 'tomafro-jekyll', '0.5.3.6'
    require 'jekyll'
    require 'tomafro/jekyll/tags/post'
    require 'tomafro/jekyll/tags/related'
    @options = Jekyll.configuration('auto' => false, 'source' => 'site', 'destination' => DESTINATION)
    @site = Jekyll::Site.new(@options)
    @site.read_posts('')
  end
end

task :render => 'jekyll:initialize' do 
  FileUtils.rm_rf(DESTINATION)
  @site.process
end

namespace :build do
  task :all => ['build:tags', 'build:archive:by_month', 'build:archive:by_year']
  
  task :tags => 'jekyll:initialize' do
    FileUtils.rm_rf(TAGS_DIR)
    FileUtils.mkdir_p(TAGS_DIR)
    tags = @site.categories
    tags.each do |tag, posts|
      File.open(File.join(TAGS_DIR, tag + ".html"), "w") do |file|
        generate_index posts, file, 'title' => "Posts tagged with #{tag}"
      end
    end
  end
  
  namespace :archive do
    task :by_month => 'jekyll:initialize' do
      by_year_and_month = @site.posts.inject({}) do |result, post|
        (result[[post.date.year, post.date.month]] ||= []) << post
        result
      end
      
      by_year_and_month.each do |(year, month), posts|
        name = Date.new(2008, month, 1).strftime("%B")
        path = File.join("site", year.to_s, "%02i.html" % month)
        FileUtils.mkdir_p(File.dirname(path))
        File.open(path, "w") do |file|
          generate_index posts, file, 'title' => "Posts from #{name} #{year}"
        end
      end
    end
    
    task :by_year => 'jekyll:initialize' do
      by_year = @site.posts.inject({}) do |result, post|
        (result[post.date.year] ||= []) << post
        result
      end

      by_year.each do |year, posts|
        path = File.join("site", year.to_s + ".html")
        FileUtils.mkdir_p(File.dirname(path))
        File.open(path, "w") do |file|
          generate_index posts, file, 'title' => "Posts from #{year}"
        end
      end
    end
  end
end

task :publish => ['update_stats', 'build:all', 'render'] do
  `cap publish`
  `curl http://rubycorner.com/ping/xmlrpc/aaf9d1cc0ecf5723fd2610063cfa60d82528cd6d`
end

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

      config = YAML.load_file("site/_config.yml")
      config["days"] = ("%10.1f" % days)
      config["minutes"] = ("%10.1f" % minutes)
      File.open("site/_config.yml", "w") do |out|
        YAML.dump(config, out)
      end
    rescue Object => e
      puts "Stats could not be updated:"
      p e
    end
  end
end

# http://rubycorner.com/ping/xmlrpc/aaf9d1cc0ecf5723fd2610063cfa60d82528cd6d