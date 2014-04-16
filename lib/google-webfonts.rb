require 'uri'
require 'action_view'
require 'active_support/core_ext'
require 'action_dispatch/http/mime_type'

# Public: Module for Google helpers
module Google
  # Public: Module for Google Webfonts helpers
  module Webfonts
    HOST = 'fonts.googleapis.com'
    PATH = '/css'
  end
end

require 'google-webfonts/version'
require 'google-webfonts/link_tag'
require 'google-webfonts/helper'

require 'google-webfonts/sinatra' if defined? Sinatra

# include the webfonts helper methods in the Rails view helpers
ActionView::Base.send :include, Google::Webfonts::Helper
