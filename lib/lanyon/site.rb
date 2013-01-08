require 'lanyon'

module Lanyon
  class Site
    attr_reader :source

    def initialize(source, destination)
      Mustache.template_path = source + "/_templates"
      Mustache.raise_on_context_miss = true
      require 'post'
      require 'tag_index'
      require 'month_index'
      require 'stylesheet'

      @source = File.expand_path(source)
      @destination = destination

      FileUtils.cd source do
        import
      end
    end

    def pages
      @pages ||= {}
    end

    def posts
      pages_with_path {|path| path.starts_with?('posts')}
    end

    def recent_posts
      posts.take(10)
    end

    def stylesheets
      pages_with_path {|path| path.starts_with?('stylesheets')}
    end

    def pages_with_path(&block)
      Collection.new(pages.select(&block).values.compact.reverse)
    end

    def updated_date_xml
      Time.now.xmlschema
    end

    def import
      @pages = Dir['**/**'].inject({}) do |contents, path|
        unless File.directory?(path) || path.starts_with?('_')
          template = load_template(path)
          contents[path] = template unless template.respond_to?(:draft?) && template.draft?
        end
        contents
      end
    end

    def load_template(path)
      in_source_folder do
        if template = template_for(path)
          template.build(self, path)
        end
      end
    end

    def layout_for(path)
      if path
        layouts[path] ||= load_template(path)
      end
    end

    def layouts
      @layouts = {}
    end

    def template_for(path, include_layouts = false)
      case File.extname path
      when '.page' then ::Page
      when '.post' then ::Post
      when '.scss' then ::Stylesheet
      when '.tag_index' then ::TagIndex
      when '.month_index' then ::MonthIndex
      when '.txt' then ::Static
      when '.ico' then ::Static
      when '.png' then ::Static
      when '.mustache' then Template
      end
    end

    def generate
      destination = Destination.new(@destination)
      pages.each do |path, page|
        puts
        puts "---"

        if page
          time "Generating #{path}" do
            page.write_to destination if page
          end
        else
          puts "Skipping #{path}"
        end
      end
    end

    private

    def in_source_folder(&block)
      FileUtils.cd source do
        return yield
      end
    end

    class Collection < Array
      define_method "take-6" do
        take(6)
      end

      define_method "leave-6" do
        from(6)
      end
    end

    class Destination
      def initialize(directory)
        @directory = directory
      end

      def write(path, content)
        full_path = File.expand_path(File.join(@directory, path))
        FileUtils.mkdir_p File.dirname(full_path)
        p full_path
        File.open full_path, 'w' do |f|
          f.write content
        end
      end
    end
  end
end