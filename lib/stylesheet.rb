require 'lanyon'
require 'sass'
require 'digest/md5'

class Stylesheet < Lanyon::Template
  def body
    @rendered_body ||= Sass::Engine.new(@body, :syntax => :scss).render
  end

  def hash
    Digest::MD5.hexdigest(body)
  end

  def url
    "/css/style-#{hash}.css"
  end

  def destination_path
    "#{url}"
  end
end