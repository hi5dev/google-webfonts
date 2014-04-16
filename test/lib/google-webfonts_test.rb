require 'test_helper'

class Google::WebfontsTest < Minitest::Test
  def test_helper_is_included_in_action_view_base
    assert ActionView::Base.ancestors.include?(Google::Webfonts::Helper)
  end

  def test_helper_is_included_in_sinatra
    assert Sinatra::Application.ancestors.include?(Google::Webfonts::Helper)
  end
end
