# coding: utf-8
# frozen_string_literal: true

require 'test_helper'

# Mock Sinatra's helpers.
module Sinatra; def self.helpers(*args) @helpers = args; end; end

module Google
  module Webfonts
    class SinatraTest < Minitest::Test
      require 'google/webfonts/sinatra'

      def test_sinatra_helper
        helpers = Sinatra.instance_variable_get(:@helpers)
        assert_includes helpers, Google::Webfonts::Helper
      end
    end
  end
end
