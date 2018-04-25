# coding: utf-8
# frozen_string_literal: true

require 'coveralls'
Coveralls.wear!

$: << File.expand_path('../lib', __dir__)

require 'google/webfonts'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!
