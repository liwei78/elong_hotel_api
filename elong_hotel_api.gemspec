# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elong_hotel_api/version'

Gem::Specification.new do |spec|
  spec.name          = "elong_hotel_api"
  spec.version       = ElongHotelApi::VERSION
  spec.authors       = ["seoaqua"]
  spec.email         = ["charles.liu23@gmail.com"]
  spec.summary       = %q{elong hotel api}
  spec.description   = %q{http://open.elong.com}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end