module Google
  module Webfonts
    # Provides a helper method for creating HTML link tags for fonts hosted
    # on Google's Webfonts CDN.
    module Helper
      # Generates a Google Webfonts link tag.
      #
      # @example Fonts without options.
      #   google_webfonts_link_tag :droid_sans, :open_sans
      #
      # @example Strings can be used for font names.
      #   # :pt_sans would be converted to 'Pt+Sans' (lower-case t), which is
      #   # an invalid font name. Strings do not get titleized, so this font
      #   # name would require a string instead of a Symbol.
      #   google_webfonts_link_tag 'PT Sans'
      #
      # @example Specifying font weights.
      #   google_webfonts_link_tag droid_sans: %w[400 500 bold bolditalic]
      #
      # @param [Array<String, Symbol, Hash{String, Symbol => Array<String>}>]
      #   options Options for the fonts.
      # @return [String] HTML with the <link> tag.
      def google_webfonts_link_tag(*options)
        # Do not create the link tag unless at least one font was given.
        fail ArgumentError, 'expected at least one font' unless options.any?

        # Create the HTML for the link tag.
        Google::Webfonts::LinkTag.new(*options).to_s
      end
    end
  end
end
