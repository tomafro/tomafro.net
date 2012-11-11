module Tomafro
  class Server
    def call(env)
      path = ::File.join("public", env["PATH_INFO"])
      path = path + "index.html" if path[/\/\Z/]
      path = path + ".html" unless path[/[^\/]+\..*\Z/]
      if ::File.exist?(path)
        [200, {"Content-Type" => content_type_for(path)}, [::File.read(path)]]
      else
        [400, {"Content-Type" => "text/html"}, [::File.read("public/404.html")]]
      end
    end

    def content_type_for(path)
      case path
      when /\.css\Z/ then "text/css"
      when /\.xml\Z/ then "application/atom+xml"
      else "text/html"
      end
    end
  end
end

run Tomafro::Server.new