# RailsPandoc

bridge to use pandoc as a converter for markdown to various output formats.

See http://johnmacfarlane.net/pandoc/README.html for more details about pandoc.
This is just a very basic interface, which doesn't support flexible options passing, etc.

It basically only supports markdown to (html or latex) fragment conversion.

## Installation

Add this line to your application's Gemfile:

    gem 'rails_pandoc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_pandoc

## Usage

markdown = "* a\n* list"

To convert some markdown into html use:
pandoc_to_html(markdown)
or the short alias: pan2h

To convert it to latex use:
pandoc_to_latex(markdown)
or the short alias: pan2l

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
