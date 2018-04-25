# coding: utf-8
# frozen_string_literal: true

# Load the library.
require 'google/webfonts'

# Add the Google Webfonts helper to Sinatra.
Sinatra.helpers(Google::Webfonts::Helper)
