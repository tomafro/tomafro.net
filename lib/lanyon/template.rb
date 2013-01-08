require 'lanyon/filters'
require 'mustache'
require 'mustache/context'

class Mustache::Context
  def with(attributes, &block)
    push attributes
    yield
  ensure
    pop
  end

  def has_key?(key)
    !!fetch(key, nil)
  rescue ContextMiss
    false
  end
end

module Lanyon
  class Template < Mustache
    include Filters

    attr_reader :path, :body

    def initialize(path, body, config = {})
      @path = path
      @body = body
      @config = config
      @config[:layout] ||= ""
      determine_template
    end

    def push_context(attributes, &block)
      context.push attributes
      yield context
    ensure
      context.pop
    end

    def render(data = template, ctx = self)
      time "template #{@path}" do
        begin
          super
        rescue Object => e
          puts e.message
          puts e.backtrace
          raise e
        end
      end
    end

    def render_page(context = self.context)
      time "page #{@path}" do
        if layout_template
          context.with content: render(template, context) do
            layout_template.render_page context
          end
        else
          render template, context
        end
      end
    end

    def write_to(destination)
      destination.write(destination_path, render_page)
    end

    def destination_path
      @config[:destination_path] || path
    end

    def draft?
      @config.has_key?(:draft) && @config[:draft]
    end

    def respond_to?(method)
      @config.has_key?(method) || super
    end

    def method_missing(method, *args, &block)
      @config.has_key?(method) ? @config[method] : super
    end

    private

    def layout_template
      @layout_template ||= site.layout_for(layout)
    end

    def determine_template
      self.template = self.class.template
    rescue Errno::ENOENT
      self.template = body
    end

    class << self
      def build(site, path)
        config, body = config_and_body(File.read(path))
        config[:site] = site
        new(path, body, config)
      end

      def config_and_body(content)
        config = if content =~ /^(---\s*\n.*?\n?)(---.*?\n)/m
          content = content[($1.size + $2.size)..-1]
          YAML.load($1)
        end || {}
        config = config.inject({}) {|memo, (key, value)| memo[key.to_sym] = value; memo }
        [config, content]
      end
    end
  end
end

class Static
  def initialize(path)
    @path = path
    @data = File.read(path)
  end

  def write_to(destination)
    destination.write(@path, @data)
  end

  class << self
    def build(site, path)
      new(path)
    end
  end
end