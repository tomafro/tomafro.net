# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lanyon/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tom Ward"]
  gem.email         = ["tom@popdog.net"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "lanyon"
  gem.require_paths = ["lib"]
  gem.version       = Lanyon::VERSION

  gem.add_dependency 'activesupport'
  gem.add_dependency 'rspec'
  gem.add_dependency 'mustache'
  gem.add_dependency 'rdiscount'
  gem.add_dependency 'pygments.rb'
  gem.add_dependency 'sass'
end
