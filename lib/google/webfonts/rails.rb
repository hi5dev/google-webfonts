# coding: utf-8
# frozen_string_literal: true

# Load the library.
require 'google/webfonts'

# Include the webfonts helper methods in the Rails view helpers.
ActionView::Base.include(Google::Webfonts::Helper)
