require 'test_helper'

# create a Sinatra route for testing
get("/") { google_webfonts_link_tag droid_sans: [400, 700] }

class SinatraTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_google_webfonts_link_tag_helper_loaded_in_sinatra
    get "/"
    options = { droid_sans: [400, 700] }
    link_tag = Google::Webfonts::LinkTag.new(request, options)
    assert_equal link_tag.result, last_response.body
  end

  private

  def request
    OpenStruct.new(:ssl? => false)
  end
end
