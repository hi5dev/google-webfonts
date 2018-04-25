# coding: utf-8
# frozen_string_literal: true

require 'coveralls'
Coveralls.wear!

$: << File.expand_path('../lib', __dir__)

require 'google/webfonts'
require 'minitest/autorun'
require 'minitest/reporters'

# Mocking a #safe_html method for strings - used to test Rails integration.
HtmlSafeString = Class.new(String)
String.define_method(:html_safe) { HtmlSafeString.new(self) }

Minitest::Reporters.use!
