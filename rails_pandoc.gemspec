# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rails_pandoc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["universa1 / jhedtrich"]
  gem.email         = ["jhedtrich@gmail.com"]
  gem.description   = %q{rails bridge to pandoc}
  gem.summary       = %q{simple rails bridge to use the pandoc library inside rails}
  gem.homepage      = "https://github.com/universal/rails_pandoc"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rails_pandoc"
  gem.require_paths = ["lib"]
  gem.version       = RailsPandoc::VERSION

  gem.add_runtime_dependency "rails", ">= 3.0.0"
  gem.add_runtime_dependency "open4", "~> 1.3.0"

  gem.add_development_dependency "rspec", "~> 2.9.0"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "guard-bundler"
  gem.add_development_dependency "rails", ">= 3.0.0"
end
