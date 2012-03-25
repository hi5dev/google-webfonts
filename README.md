# Google::Webfonts

Provides a helper for using [Google Webfonts](http://www.google.com/webfonts) in
Rails or Sinatra, although it can be used outside of those frameworks as well.

## Installation

Add this line to your application's Gemfile:

    gem 'google-webfonts'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google-webfonts

## Usage

### Syntax

    google_webfonts_link_tag :font_name => [sizes], ...

### Examples

Basic usage:

    google_webfonts_link_tag :droid_sans        => [400, 700],
                             :yanone_kaffeesatz => [300, 400]

The sizes are optional, and do not have to be in an Array if you are only
including one size. For example:

    google_webfonts_link_tag :droid_sans
    # => generates a tag for Droid+Sans without specifying the font weight
    
    google_webfonts_link_tag :droid_sans => 400
    # => generates a tag for Droid+Sans with 400 weight
    
    google_webfonts_link_tag :droid_sans => [400, 700]
    # => generates a tag for Droid+Sans with 400 and 700 weights

You can also use a String instead of a Symbol if you'd prefer. For example:

    google_webfonts_link_tag "Droid Sans", "Yanone Kaffeesatz" => 400
    # includes Droid+Sans without a specified weight
    # and Yanone+Kaffeesatz with weight 400

### Using in Rails

No additional work required to use this gem in a Rails application. Just add
it to your application's Gemfile, and it is automatically available in your
views.

You will, however, need to `include Google::Webfonts::Helper` if you want to use
it outside of a view.

### Using in Sinatra

Here is a simple "Hello World" example for using Google::Webfonts in a Sinatra
app:

    # app.rb
    require 'rubygems'
    require 'sinatra'
    require 'google-webfonts' # <= this must be required after 'sinatra'
    
    get '/' do
      erb :index
    end
    
    # views/index.erb
    <html>
      <head>
        <%= google_webfonts_link_tag "Droid Sans" %>
      </head>
      <body>
        <p style="font-family: 'Droid+Sans', sans-serif;">
          Hello World!
        </p>
      </body>
    </html>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Ensure what your code is well tested, and all the tests pass. (`rspec spec`)
6. Create new Pull Request
