# coding: utf-8
# frozen_string_literal: true

require 'test_helper'

# Mocking Sinatra::helpers method to prevent errors.
module Sinatra; def self.helpers(*); end; end

class DeprecatedSinatraRequire < Minitest::Test
  def test_deprecated_require
    _, err = capture_io { require 'google-webfonts/sinatra' }
    assert_includes err, 'DEPRECATED'
  end
end
