module Google
  module Webfonts

    # Public: Helper module that includes the google_webfonts_link_tag method.
    # This module is automatically included in your Rails view helpers.
    module Helper
      # Public: Generates a Google Webfonts link tag
      #
      # If you need to specify a font size, use a Hash. Symbols will be
      # titleized, so if the font you're using uses a specialized case
      # (e.g: "PT Sans"), then you'll need to use a String.
      #
      # You can specify subsets by using the :subset option. Note that this must
      # be a Symbol. "Subset" and "subset" would be turned into a font.
      #
      # options - The font options. This can be a String, Symbol, or Hash, or
      #           a combination of all three.
      #
      # Examples
      #
      #   google_webfonts_link_tag "PT Sans"
      #
      #   google_webfonts_link_tag :droid_sans
      #
      #   google_webfonts_link_tag droid_sans: [400, 700]
      #
      #   google_webfonts_link_tag droid_sans: [400, 700],
      #                            yanone_kaffeesatz: 700
      #
      #   google_webfonts_link_tag :droid_sans,
      #                            yanone_kaffeesatz: 400,
      #                            "PT Sans" => [400, 700]
      #
      #   google_webfonts_link_tag :droid_sans, subset: %w[latin cyrillic]
      #
      # Returns a <link> tag for the Google Webfonts stylesheet.
      # Raises ArgumentError if no options are passed.
      def google_webfonts_link_tag(*opts)
        raise ArgumentError, 'expected at least one font', caller if opts.empty?
        LinkTag.new(request, *opts).result
      end
    end
  end
end
