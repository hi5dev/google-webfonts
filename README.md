# Google::Webfonts

[![Build Status](https://travis-ci.org/hi5dev/google-webfonts.svg?branch=master)](https://travis-ci.org/hi5dev/google-webfonts)
[![Coverage Status](https://coveralls.io/repos/github/hi5dev/google-webfonts/badge.svg)](https://coveralls.io/github/hi5dev/google-webfonts)

Provides a helper for using [Google Webfonts](http://www.google.com/webfonts)
with the Ruby programming language.

## Installation

Add this line to your application's Gemfile:

    gem 'google-webfonts'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google-webfonts

## Usage

```ruby
include Google::Webfonts::Helper

google_webfonts_link_tag font_name: [weights]
```

### Examples

#### Basic usage:

```ruby
google_webfonts_link_tag droid_sans: [400, 700], yanone_kaffeesatz: [300, 400]
```

The weights are optional, and do not have to be in an Array if you are only
including one. For example:

```ruby
# Generate a tag for Droid+Sans without specifying the font weight.
google_webfonts_link_tag :droid_sans

# Generate a tag for Droid+Sans with 400 weight.
google_webfonts_link_tag :droid_sans => 400

# Generate a tag for Droid+Sans with 400 and 700 weights.
google_webfonts_link_tag :droid_sans => [400, 700]
```

In certain cases it will be necessary to use Strings instead of Symbols for the 
font names. The helper method titleizes the symbols when converting it to a 
Google Webfonts compatible name. This does not work for every font name. For 
example:  

```ruby
# If a Symbol was provided here, the "T" would be lower-case, which would 
# result in an invalid link.
google_webfonts_link_tag 'PT Sans'
```

### Using in Rails

Require the gem like this in your Gemfile when using with Rails:

```ruby
gem 'google-webfonts', require: 'google/webfonts/rails'
```

The `google_webfonts_link_tag` helper method will automatically be available 
to your views. If you need to use it outside of the views, include this module:

```ruby
include Google::Webfonts::Helper
```

### Using in Sinatra

Here is a simple "Hello World" example for using Google::Webfonts in a Sinatra
app:

```ruby
# app.rb
require 'rubygems'
require 'sinatra'

# This must be required after requiring sinatra.
require 'google/webfonts/sinatra'

get '/' do
  erb :index
end
```

###

```erb
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
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, 
run `rake test` to run the tests. You can also run `bin/console` for an 
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/hi5dev/google-webfonts.
