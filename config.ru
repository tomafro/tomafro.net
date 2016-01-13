require 'mime/types'

module Tomafro
  class Server
    def call(env)
      path = ::File.join("public", env["PATH_INFO"])
      path = path + "index.html" if path[/\/\Z/]
      path = path + ".html" unless path[/[^\/]+\..*\Z/]

      if ::File.exist?(path)
        [200, {"Content-Type" => content_type_for(path)}, response(env, path)]
      else
        [404, {"Content-Type" => "text/html"}, response(env, "public/404.html")]
      end
    end

    def content_type_for(path)
      MIME::Types.type_for(path).first.to_s
    end

    def response(env, path)
      request = Rack::Request.new(env)
      if request.head?
        []
      else
        [::File.read(path)]
      end
    end

  end
end

run Tomafro::Server.new
