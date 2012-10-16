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


This gem needs `pandoc` which can be installed using `cabal`:
 
    cabal install pandoc
 
`sanitize` is a self-written Haskell-module, which can be found in `GEM_ROOT/haskell/`. This depends on the cabal package `xss-sanitize`:
 
    cabal install xss-sanitize
 
Afterwards the module can be compiled and the binary moved to your prefered location:
 
    cd GEM_ROOT/haskell/
    ghc --make sanitize.hs
    mv sanitize ~/.cabal/bin
    rm sanitize.hi sanitize.o

## Usage

markdown = "* a\n* list"

To convert some markdown into html use:
pandoc_to_html(markdown)
or the short alias: pan2h

To convert it to latex use:
pandoc_to_latex(markdown)
or the short alias: pan2l

## TODO

Check if pandoc and xss-sanitize are installed and if not tell the user that those dependencies need to be installed/ask the user to install them for him!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
