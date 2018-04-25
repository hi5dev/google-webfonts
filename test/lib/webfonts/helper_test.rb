# coding: utf-8
# frozen_string_literal: true

require 'test_helper'

module Google
  module Webfonts
    class HelperTest < Minitest::Test
      include Google::Webfonts::Helper

      def test_without_fonts
        error = assert_raises(ArgumentError) { google_webfonts_link_tag }
        assert_equal 'expected at least one font', error.message
      end

      def test_with_font_names
        exp = Google::Webfonts::LinkTag.new(:droid_sans).to_s
        act = google_webfonts_link_tag(:droid_sans)
        assert_equal exp, act
      end

      def test_with_font_options
        exp = Google::Webfonts::LinkTag.new(droid_sans: 400).to_s
        act = google_webfonts_link_tag(droid_sans: 400)
        assert_equal exp, act
      end
    end
  end
end
