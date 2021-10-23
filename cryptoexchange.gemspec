# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cryptoexchange/version'

Gem::Specification.new do |spec|
  spec.name          = "cryptoexchange"
  spec.version       = Cryptoexchange::VERSION
  spec.authors       = ["TM Lee"]
  spec.email         = ["tm89lee@gmail.com"]

  spec.summary       = "Ruby library to query market data from cryptocurrency exchanges."
  spec.description   = "Ruby library to query market data from cryptocurrency exchanges."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 13.0.1"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rb-readline"
  spec.add_development_dependency "vcr", "~> 4.0.0"
  spec.add_development_dependency "webmock", '~> 3.3.0'
  spec.add_development_dependency "byebug"

  spec.add_dependency "http", '5.0.0.pre'
  spec.add_dependency "graphql", '1.10.6'
  spec.add_dependency "graphql-client", '0.16.0'
  spec.add_dependency "lru_redux"
  spec.add_dependency "websocket-eventmachine-client"
end
