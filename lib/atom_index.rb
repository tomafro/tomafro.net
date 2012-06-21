require 'lanyon'

class AtomIndex < Lanyon::Template
  def url
    "/atom.xml"
  end

  def destination_path
    "atom.xml"
  end

  def posts
  end
end