# -*- encoding: utf-8 -*-
require File.expand_path('../lib/google-webfonts/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Travis Haynes"]
  gem.email         = ["travis.j.haynes@gmail.com"]
  gem.description   = %q{Provides a helper for using Google Webfonts in a Rails application.}
  gem.summary       = %q{Provides a helper for using Google Webfonts in a Rails application.}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "google-webfonts"
  gem.require_paths = ["lib"]
  gem.version       = Google::Webfonts::VERSION
  
  gem.add_runtime_dependency      'actionpack', '>= 3.0.0'
  
  gem.add_development_dependency  'rspec',      '~> 2.8.0'
  gem.add_development_dependency  'tomdoc',     '~> 0.2.5'
end
