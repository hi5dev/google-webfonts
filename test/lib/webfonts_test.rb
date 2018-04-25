# coding: utf-8
# frozen_string_literal: true

require 'test_helper'

module Google
  class WebfontsTest < Minitest::Test
    def test_cdn_host
      assert_kind_of String, Google::Webfonts::CDN_HOST
      assert Google::Webfonts::CDN_HOST.frozen?
    end

    def test_cdn_path
      assert_kind_of String, Google::Webfonts::CDN_PATH
      assert Google::Webfonts::CDN_PATH.frozen?
    end
  end
end
