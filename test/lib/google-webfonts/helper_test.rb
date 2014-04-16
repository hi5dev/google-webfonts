require 'test_helper'

module Google
  module Webfonts
    class HelperTest < Minitest::Test
      include Helper

      def test_google_webfonts_link_tag
        options = { droid_sans: [400, 700] }
        link_tag = LinkTag.new(request, options)
        assert_equal link_tag.result, google_webfonts_link_tag(options)
      end

      private

      def request
        OpenStruct.new(:ssl? => false)
      end
    end
  end
end
