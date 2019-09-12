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

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'daru'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'parallel_tests'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
end
