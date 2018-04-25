# coding: utf-8
# frozen_string_literal: true

# Load the library.
require 'google/webfonts'
require 'google/webfonts/link_tag'

Google::Webfonts::LinkTag.define_method(:to_s) do
  # The default implmentation will escape the HTML when used with Rails.
  # This override ensures that the HTML is actually included document
  # rather than displayed as text in the browser.
  to_html.html_safe
end

# Include the webfonts helper methods in the Rails view helpers.
ActionView::Base.include(Google::Webfonts::Helper)
