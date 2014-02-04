module Google
  module Webfonts
  
    # Public: Helper module that includes the google_webfonts_link_tag method.
    # This module is automatically included in your Rails view helpers.
    module Helper
      include ActionView::Helpers::TagHelper
      
      # Public: Generates a Google Webfonts link tag
      # 
      # options - The font options. This can be a String, Symbol, or Hash, or
      #           a combination of all three. If you need to specify a font
      #           size, use a Hash, otherwise a String or Symbol will work.
      #
      # Examples
      #
      #   google_webfonts_link_tag "Droid Sans"
      #   # => '<link href="http://fonts.googleapis.com/css?family=Droid+Sans" rel="stylesheet" type="text/css" />'
      # 
      #   google_webfonts_link_tag :droid_sans
      #   # => '<link href="http://fonts.googleapis.com/css?family=Droid+Sans" rel="stylesheet" type="text/css" />'
      # 
      #   google_webfonts_link_tag :droid_sans => [400, 700]
      #   # => '<link href="http://fonts.googleapis.com/css?family=Droid+Sans:400,700" rel="stylesheet" type="text/css" />'
      # 
      #   google_webfonts_link_tag :droid_sans => [400, 700],
      #                            :yanone_kaffeesatz => [300, 400]
      #   # => '<link href="http://fonts.googleapis.com/css?family=Droid+Sans:400,700|Yanone+Kaffeesatz:300,400" rel="stylesheet" type="text/css" />'
      # 
      #   google_webfonts_link_tag "Droid Sans",
      #                            :yanone_kaffeesatz => 400
      #   # => '<link href="http://fonts.googleapis.com/css?family=Droid+Sans|Yanone+Kaffeesatz:400" rel="stylesheet" type="text/css" />'
      #
      # Returns a <link> tag for the Google Webfonts stylesheet.
      # Raises ArgumentError if no options are passed.
      # Raises ArgumentError if an option is not a Symbol, String, or Hash.
      # Raises ArgumentError if a size is not a String or Fixnum.
      def google_webfonts_link_tag(*options)
        raise ArgumentError, "expected at least one font" if options.empty?
        
        fonts = []
        
        options.each do |option|
          case option.class.to_s
          when "Symbol"
            # include the font
            fonts << prepare_font_name(option)
          when "String"
            # Allow font names passed literally (eg: 'Alegreya SC' is broken by titleize)
            fonts << prepare_font_name(option)
          when "Hash"
            fonts += option.inject([]) do |result, (font_name, sizes)|
              # ensure sizes is an Array
              sizes = Array(sizes)
              
              sizes.all? do |size|
                unless size.class == Fixnum || size.class == String
                  raise ArgumentError, "expected a Fixnum or String, got a #{size.class}"
                end
              end
              
              font_name = prepare_font_name(font_name)

              # return font_name:sizes where
              # sizes is a comma separated list
              result << "#{font_name}:#{sizes.join(",")}"
            end
          else
            raise ArgumentError, "expected a String, Symbol, or a Hash, got a #{option.class}"
          end
        end
        
        # the fonts are separated by pipes
        family = fonts.join("|")

        # generate https links if we are an https site
        request_method = "http"
        #request_method = "https" if request and request.ssl? # FIXME: does not work in specs (request not defined), does it work elsewhere?
          
        # return the link tag
        tag 'link', {
            :rel  => :stylesheet,
            :type => Mime::CSS,
            :href => "#{request_method}://fonts.googleapis.com/css?family=#{family}"
          },
          false,
          false
      end

      private
      # Prepare the font name for inclusion in a URI.
      #
      # raw_name can be either a string or a symbol.
      def prepare_font_name(raw_name)
        font_name = raw_name
        case raw_name.class.to_s
        when "String"
        when "Symbol"
          # titleize the font name
          font_name = font_name.to_s.titleize
        else
          raise ArgumentError, "expected a String or Symbol as the font name, got a #{raw_name.class}"
        end
        # convert the spaces into pluses 
        font_name = font_name.gsub(" ", "+")
        font_name
      end
    end
    
  end
end
