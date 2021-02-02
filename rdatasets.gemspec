# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rdatasets/version'

Gem::Specification.new do |spec|
  spec.name          = 'rdatasets'
  spec.version       = RDatasets::VERSION
  spec.authors       = ['kojix2']
  spec.email         = ['2xijok@gmail.com']

  spec.summary       = 'Ruby package for loading classical data sets vailable in R'
  spec.description   = 'Ruby package for loading classical data sets vailable in R'
  spec.homepage      = 'https://github.com/kojix2/rdatasets'

  spec.files = Dir['*.{md,txt}', '{lib}/**/*', '{data}/**/*']
  spec.require_paths = ['lib']

  spec.add_dependency 'daru'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'parallel_tests'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rover-df'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
