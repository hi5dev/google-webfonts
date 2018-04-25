# coding: utf-8
# frozen_string_literal: true

require 'test_helper'

# Mocking ActionView::Base class.
class ActionView; class Base; end; end

module Google
  module Webfonts
    class DeprecatedRequireTest < Minitest::Test
      def test_deprecated_require
        _, err = capture_io { require 'google-webfonts' }
        assert_includes err, 'DEPRECATED'
      end
    end
  end
end
