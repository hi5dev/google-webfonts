module Google
  module Webfonts
    class LinkTag
      include ActionView::Helpers::TagHelper

      attr_reader :result

      def initialize(request, *opts)
        @request = request
        fonts = fonts_from_options(opts)
        @result = tag(:link, link_options(fonts))
      end

      def to_s
        @result
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
        hash.inject([]) do |result, (font_name, sizes)|
          font_name = parse_google_webfont_name(font_name)
          result << "#{font_name}:#{Array(sizes).join(",")}"
        end
      end

      def parse_google_webfont_name(name)
        name = name.to_s.titleize if name.is_a?(Symbol)
        name.gsub("_", " ")
      end

      def link_options(fonts)
        { rel: 'stylesheet',
          type: Mime::CSS,
          href: uri(fonts).to_s }
      end

      def uri(fonts)
        family = fonts.join("|")
        u = @request.ssl? ? URI::HTTPS : URI::HTTP
        u.build(host: HOST, path: PATH, query: { family: family }.to_query)
      end
    end
  end
end
