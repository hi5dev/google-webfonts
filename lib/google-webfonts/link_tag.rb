module Google
  module Webfonts
    class LinkTag
      include ActionView::Helpers::TagHelper

      attr_reader :result

      alias_method :to_s, :result

      def initialize(request, *opts)
        @request = request
        @subsets = []
        @fonts = fonts_from_options(opts)
        @result = tag(:link, link_options, false, false)
      end

      private

      def fonts_from_options(opts)
        opts.map {|option| parse_google_webfont_option(option) }.flatten
      end

      def parse_google_webfont_option(option)
        case option
        when Symbol, String then parse_google_webfont_name(option)
        when Hash then parse_google_webfont_hash(option)
        else ""
        end
      end

      def parse_google_webfont_hash(hash)
        add_subsets(hash.delete(:subset))

        hash.inject([]) do |result, (font_name, sizes)|
          font_name = parse_google_webfont_name(font_name)
          result << "#{font_name}:#{Array(sizes).join(",")}"
        end
      end

      def parse_google_webfont_name(name)
        name = name.to_s.titleize if name.is_a?(Symbol)
        name.gsub("_", " ")
      end

      def link_options
        { rel: 'stylesheet',
          type: type_css,
          href: uri.to_s }
      end

      def add_subsets(subsets)
        @subsets += Array(subsets)
      end

      def uri
        u = @request.ssl? ? URI::HTTPS : URI::HTTP
        u.build(host: HOST, path: PATH, query: uri_query)
      end

      def uri_query
        {}.tap {|q|
          q['family'] = @fonts.join("|")
          q['subset'] = @subsets.join(",") if @subsets.any?
        }.to_query
      end
      
      private

        def type_css
          if ActionPack::VERSION::MAJOR < 5
            return Mime::CSS
          end

          return Mime[:css]
        end
    end
  end
end
