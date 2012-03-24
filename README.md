# Google::Webfonts

Provides a helper for using Google Webfonts in a Rails application.


## Installation

Add this line to your application's Gemfile:

    gem 'google-webfonts'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google-webfonts


## Usage

    webfonts_link_tag :font => [sizes], ...

### Examples

    # generate a tag for Dosis and Revalia fonts
    # without a specified font weights
    webfonts_link_tag :dosis, :revalia

    # generate a tag for Droid+Sans in weights 400 and 700
    webfonts_link_tag :droid_sans => [400, 700]
    
    # generate a tag for the above font and
    # Yanone+Kaffeesatz in weights 300 and 400
    webfonts_link_tag :droid_sans => [400, 700], :yanone_kaffeesatz => [300, 400]
    

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
