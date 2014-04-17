require 'test_helper'

module Google
  module Webfonts
    class LinkTagTest < Minitest::Test
      def setup
        @http_request = OpenStruct.new(:ssl? => false)
        @https_request = OpenStruct.new(:ssl? => true)
      end

      def test_subsets
        tag = LinkTag.new(@http_request, droid_sans: [400, 700],
          subset: %w[latin cyrillic]).result
        assert_tag tag, 'link',
          href: 'http://fonts.googleapis.com/css?family=Droid+Sans%3A400%2C700&subset=latin%2Ccyrillic'
      end

      def test_uri_protocol
        tag = LinkTag.new(@http_request, droid_sans: [400, 700]).result
        assert_tag tag, 'link',
          href: 'http://fonts.googleapis.com/css?family=Droid+Sans%3A400%2C700'

        tag = LinkTag.new(@https_request, droid_sans: [400, 700]).result
        assert_tag tag, 'link',
          href: 'https://fonts.googleapis.com/css?family=Droid+Sans%3A400%2C700'
      end

      def test_with_font_sizes
        tag = LinkTag.new(@http_request, droid_sans: [400, 700]).result
        assert_tag tag, 'link',
          href: 'http://fonts.googleapis.com/css?family=Droid+Sans%3A400%2C700'

        tag = LinkTag.new(@http_request, droid_sans: [400, 700],
          'PT Sans' => [400, 700]).result
        assert_tag tag, 'link',
          href: 'http://fonts.googleapis.com/css?family=Droid+Sans%3A400%2C700%7CPT+Sans%3A400%2C700'
      end

      def test_strings_are_not_titleized
        tag = LinkTag.new(@http_request, 'PT Sans').result
        assert_tag tag, 'link',
          href: 'http://fonts.googleapis.com/css?family=PT+Sans'
      end

      def test_symbols_are_titleized
        tag = LinkTag.new(@http_request, :droid_sans).result
        assert_tag tag, 'link',
          href: 'http://fonts.googleapis.com/css?family=Droid+Sans'
      end
    end
  end
end
