# coding: utf-8
# frozen_string_literal: true

module Google
  module Webfonts
    # Used to simplify creating <link> tags for Google's Webfonts CDN.
    #
    # @example
    #   tag = Google::Webfonts::LinkTag.new(:droid_sans => %w[400 500i])
    #   html = tag.to_s
    class LinkTag
      attr_reader :options

      # Creates a new {Google::Webfonts::LinkTag} instance.
      #
      # @return [Google::Webfonts::LinkTag] The new {LinkTag} instance.
      def initialize(*options)
        @options = parse_options(options).freeze
      end

      # When making headers or display texts on your website, you'll often
      # want to stylize your text in a decorative way. To simplify your work,
      # Google has provided a collection of font effects that you can use
      # with minimal effort to produce beautiful display text.
      #
      # To use feature, simply add an +effect:+ option when initializing the
      # link tag. Then add the corresponding class name to the HTML element(s)
      # that you want to affect.
      #
      # At the time that version 0.3.0 of this gem was released, this was a
      # beta feature provided by Google.
      #
      # @see https://developers.google.com/fonts/docs/getting_started
      # @return [Array<String>] Any effects to applied to the font.
      def effect
        options[:effect]
      end

      # Parses the options provided to the initializer into a list of font
      # families.
      #
      # @return [String] The font family formatted for Google Webfont's API.
      def family
        @family ||= family_options.map do |font_name, font_options|
          name = parse_font_name(font_name)

          options = font_options.sort.uniq

          options.any? ? "#{name}:#{options.join(',')}" : name
        end.join('|')
      end

      # Creates the hypertext reference (URL) to the font.
      #
      # @return [URI] URL to the font on Google's CDN.
      def href
        # Return the cached value when present.
        return @href unless @href.nil?

        # Create a URI to Google's CDN.
        uri = URI.join(Google::Webfonts::CDN_HOST, Google::Webfonts::CDN_PATH)

        uri.query = "family=#{family}"

        uri.query += "&text=#{CGI.escape(text.join)}" unless text.nil?

        uri.query += "&effect=#{CGI.escape(effect.join(','))}" unless effect.nil?

        @href = uri
      end

      # Oftentimes, when you want to use a web font on your website or
      # application, you know in advance which letters you'll need. This
      # often occurs when you're using a web font in a logo or heading.
      #
      # In these cases, you should consider specifying a text= value in your
      # font request URL. This allows Google to return a font file that's
      # optimized for your request. In some cases, this can reduce the size
      # of the font file by up to 90%.
      #
      # At the time that version 0.3.0 of this gem was released, this was a
      # beta feature provided by Google.
      #
      # @see https://developers.google.com/fonts/docs/getting_started
      # @return [Array<String>] Which letters to include in the font.
      def text
        options[:text]
      end

      # Converts the link tag to HTML.
      #
      # @return [String] HTML for the link tag.
      def to_s
        to_html
      end

      protected

      # This is used by #to_s to create a <link> tag so that #to_s can be
      # overridden depending on the web framework being used - e.g. with Rails.
      #
      # @return [String] HTML for the link tag.
      def to_html
        %(<link href="#{href}" rel="stylesheet">)
      end

      private

      # Extracts the options for the font families.
      #
      # @return [Hash{String, Symbol => Array<Integer, String>}] The families.
      def family_options
        options.reject {|k,_| %i[effect text].include?(k) }
      end

      # Converts the Ruby-friendly font name provided to the initializer to a
      # URL-encoded font name that Google's CDN will recognize.
      #
      # @param [String, Symbol] font_name The given font name.
      # @return [String] A URI-encoded key name.
      def parse_font_name(font_name)
        # Strings only get URI-encoded.
        return CGI.escape(font_name) if font_name.is_a?(String)

        # Convert the font name into an array of its words.
        words = "#{font_name}".split('_')

        # Capitalize each word in the font name.
        words.map!(&:capitalize)

        # Convert back to a String, joined by spaces instead of underscores.
        font_name = words.join(' ')

        # URI-encode the font name.
        CGI.escape(font_name)
      end

      # Parses the options given to the initializer into a Hash.
      #
      # @return [Hash{String, Symbol => Array}] Options for the LinkTag.
      def parse_options(options)
        {}.tap do |parsed|
          options.each { |opt| parse_option(opt, parsed) }
        end
      end

      # @param [Hash, String, Symbol] opt
      # @param [Hash] parsed
      # @return [Array<String, Array>]
      # @raise [ArgumentError] If an option cannot be parsed.
      def parse_option(opt, parsed)
        # Font names without options are converted to names with empty options.
        return parsed[opt] = [] if opt.is_a?(String) || opt.is_a?(Symbol)

        # Add any option in a Hash, ensuring that its value is an Array.
        return opt.each { |k, v| parsed[k] = Array(v) } if opt.is_a?(Hash)

        # Reject unknown arguments.
        fail ArgumentError, "invalid argument: #{opt.inspect}", caller
      end
    end
  end
end
