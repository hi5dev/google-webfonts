# coding: utf-8
# frozen_string_literal: true

require 'test_helper'

module Google
  module Webfonts
    class LinkTagTest < Minitest::Test
      def test_options
        tag = LinkTag.new(:droid_sans, 'PT Sans' => 400)
        assert_kind_of Array, tag.options[:droid_sans]
        assert tag.options[:droid_sans].empty?

        assert_kind_of Array, tag.options['PT Sans']
        assert_equal 1, tag.options['PT Sans'].count
        assert_includes tag.options['PT Sans'], 400

        assert tag.options.frozen?
      end

      def test_invalid_arguments
        error = assert_raises(ArgumentError) { LinkTag.new(1) }
        assert_equal 'invalid argument: 1', error.message
      end

      def test_effect
        tag = LinkTag.new(effect: 'shadow-multiple')
        assert_kind_of Array, tag.effect
        assert_includes tag.effect, 'shadow-multiple'
      end

      def test_text
        tag = LinkTag.new(text: 'Hello')
        assert_kind_of Array, tag.text
        assert_includes tag.text, 'Hello'
      end

      def test_family
        tag = LinkTag.new(:droid_sans, 'PT Sans' => %w[400 500i])
        assert_equal 'Droid+Sans|PT+Sans:400,500i', tag.family
      end

      def test_family_weights_are_unique
        tag = LinkTag.new(droid_sans: %w[400 400 400i])
        assert_equal 'Droid+Sans:400,400i', tag.family
      end

      def test_family_weights_are_sorted
        tag = LinkTag.new(droid_sans: %w[500 700 400])
        assert_equal 'Droid+Sans:400,500,700', tag.family
      end

      def test_href
        tag = LinkTag.new(:droid_sans)
        assert_kind_of URI, tag.href
        exp = 'https://fonts.googleapis.com/css?family=Droid+Sans'
        assert_equal exp, tag.href.to_s

        tag = LinkTag.new(:droid_sans, 'PT Sans' => %w[400 700 700i])
        exp += '|PT+Sans:400,700,700i'
        assert_equal exp, tag.href.to_s

        tag = LinkTag.new(:droid_sans,
          'PT Sans' => %w[400 700 700i],
          text: 'Hello World'
        )
        exp += '&text=Hello+World'
        assert_equal exp, tag.href.to_s

        tag = LinkTag.new(:droid_sans,
          'PT Sans' => %w[400 700 700i],
          text: 'Hello World',
          effect: 'shadow-multiple'
        )
        exp += '&effect=shadow-multiple'
        assert_equal exp, tag.href.to_s
      end

      def test_to_s
        tag = LinkTag.new(:droid_sans)
        url = 'https://fonts.googleapis.com/css?family=Droid+Sans'
        exp = %Q(<link href="#{url}" rel="stylesheet">)
        assert_equal exp, tag.to_s
      end
    end
  end
end
