# coding: utf-8
# frozen_string_literal: true

require 'cgi'
require 'uri'

module Google
  module Webfonts
    # The host name for the Google Webfonts CDN.
    CDN_HOST = 'https://fonts.googleapis.com'

    # The path name for the Google Webfonts on the CDN.
    CDN_PATH = 'css'

    # Auto load all of the subclasses.
    autoload :Helper, 'google/webfonts/helper'
    autoload :LinkTag, 'google/webfonts/link_tag'
    autoload :VERSION, 'google/webfonts/version'
  end
end
