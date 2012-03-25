require "action_view"

# Public: Module for Google helpers
module Google
  # Public: Module for Google Webfonts helpers
  module Webfonts
  end
end

require "google-webfonts/version"
require "google-webfonts/helper"

require 'google-webfonts/sinatra' if defined? Sinatra

# include the webfonts helper methods in the Rails view helpers
ActionView::Base.send :include, Google::Webfonts::Helper
