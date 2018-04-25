# coding: utf-8
# frozen_string_literal: true

require 'test_helper'

module Google
  module Webfonts
    class VersionTest < Minitest::Test
      def test_version_is_semantic
        regex = /^([0-9]+)\.([0-9]+)\.([0-9]+)?$/
        assert_match regex, Google::Webfonts::VERSION
      end

      def test_version_is_frozen
        assert Google::Webfonts::VERSION.frozen?
      end
    end
  end
end
