# coding: utf-8
# frozen_string_literal: true

require 'test_helper'

# Mock ActionView::Base for these tests.
class ActionView; class Base; end; end

module Google
  module Webfonts
    class RailsTest < Minitest::Test
      def setup
        require 'google/webfonts/rails'
      end

      # Restore the default #to_html implementation when these tests finish.
      Minitest.after_run do
        Google::Webfonts::LinkTag.define_method(:to_s) { to_html }
      end

      def test_action_view_helper
        view = ActionView::Base.new
        assert_respond_to view, :google_webfonts_link_tag
      end

      def test_html_safe
        tag = Google::Webfonts::LinkTag.new
        assert_kind_of HtmlSafeString, tag.to_s
      end
    end
  end
end
