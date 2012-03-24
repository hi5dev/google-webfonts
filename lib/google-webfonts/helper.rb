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
          when "Symbol", "String"
            # titleize the font name
            font_name = option.to_s.titleize
            
            # replace any spaces with pluses
            font_name = font_name.gsub(" ", "+")
            
            # include the font
            fonts << font_name
          when "Hash"
            fonts += option.inject([]) do |result, (font_name, sizes)|
              # ensure sizes is an Array
              sizes = Array(sizes)
              
              sizes.all? do |size|
                unless size.class == Fixnum || size.class == String
                  raise ArgumentError, "expected a Fixnum or String, got a #{size.class}"
                end
              end
              
              # convert font name into a String
              font_name = font_name.to_s
              
              # replace underscores with spaces
              # and titleize the font name
              font_name = font_name.gsub("_", " ")
              font_name = font_name.titleize
              
              # convert the spaces into pluses 
              font_name = font_name.gsub(" ", "+")
              
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
        
        # return the link tag
        tag 'link', {
            :rel  => :stylesheet,
            :type => Mime::CSS,
            :href => "http://fonts.googleapis.com/css?family=#{family}"
          },
          false,
          false
      end
    end
    
  end
end
