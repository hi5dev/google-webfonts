# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google-webfonts/version'

Gem::Specification.new do |spec|
  spec.name = "google-webfonts"
  spec.version = Google::Webfonts::VERSION
  spec.authors = ["Travis Haynes"]
  spec.email = ["travis.j.haynes@gmail.com"]

  spec.summary = "Provides a helper for using Google Webfonts in Rails or " +
                 "Sinatra, although it can be used outside of those " +
                 "frameworks as well."

  spec.description = "Google Webfonts helper for Rails or Sinatra applications."

  spec.homepage = "https://github.com/travishaynes/Google-Webfonts-Helper"
  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^test/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'actionpack', '>= 3.0.0'

  spec.add_development_dependency 'bundler', '>= 1.3.0', '< 2.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 5.3.3'
  spec.add_development_dependency 'sinatra', '~> 1.3.2'
end
