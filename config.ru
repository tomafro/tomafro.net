require 'mime/types'

module Tomafro
  class Server
    class << self
      def call(env)
        new(env).call
      end
    end

    attr_reader :env, :request

    def initialize(env)
      @env = env
      @request = Rack::Request.new(env)
    end

    def call
      path = ::File.join("public", env["PATH_INFO"])
      path = path + "index.html" if path[/\/\Z/]
      path = path + ".html" unless path[/[^\/]+\..*\Z/]

      if ::File.exist?(path)
        respond_with_file 200, path
      else
        respond_with_file 404, "public/404.html"
      end
    end

    def respond_with_file(status, path)
      type = MIME::Types.type_for(path).first

      headers = { "Accept-CH" => "DPR"}

      if type.media_type == "image"
        dpr = (env["HTTP_DPR"] || "1.0").to_f.ceil
        alternative = path.gsub(/\.([A-z]+)\Z/) do |ext|
          "@#{dpr}x#{ext}"
        end

        headers["Vary"] = "DPR"

        if File.exists?(alternative)
          path = alternative
          headers["Content-DPR"] = "#{dpr}.0"
        end
      end

      body = request.head? ? [] : [File.read(path)]
      [status, headers.merge("Content-Type" => type.to_s, "Content-Length" => File.size(path).to_s), body]
    end
  end
end

run Tomafro::Server
