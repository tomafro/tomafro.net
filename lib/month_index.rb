require 'lanyon'

class MonthIndex < Lanyon::Template
  def layout
    "_layouts/default.mustache"
  end

  def write_to(destination)
    years = site.posts.compact.collect {|p| p.date.year }.compact
    years.each do |year|
      year_posts = site.posts.compact.select {|p| p.date.year == year }
      months = year_posts.collect {|p| p.date.month }
      months.each do |month|
        posts = year_posts.select {|p| p.date.month == month }.compact
        m = (month < 10) ? "0#{month}" : month.to_s
        raise "#{month}" if m.blank?

        push_context posts: posts, title: "Posts from #{m}/#{year}", url: "/#{year}/#{m}" do
          destination.write "/#{year}/#{m}.html", render_page(context)
        end
      end
    end
  end
end