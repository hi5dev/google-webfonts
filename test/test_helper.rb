ENV['RACK_ENV'] = 'test'

require 'ostruct'
require 'sinatra'
require 'google-webfonts'
require 'minitest/autorun'
require 'minitest/unit'
require 'rack/test'

class Minitest::Test
  def assert_tag(el, tag, props={})
    assert el =~ /<#{tag}.*\/>/ , "expected a #{tag} tag"
    assert props.all? {|key, value| el.include?("#{key}=\"#{value}\"") },
      "tag's properties do not match"
  end
end
