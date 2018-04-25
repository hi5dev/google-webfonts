# coding: utf-8
# frozen_string_literal: true

require 'test_helper'

# Mock ActionView::Base for these tests.
class ActionView; class Base; end; end

module Google
  module Webfonts
    class RailsTest < Minitest::Test
      require 'google/webfonts/rails'

      def test_action_view_helper
        view = ActionView::Base.new
        assert_respond_to view, :google_webfonts_link_tag
      end
    end
  end
end
