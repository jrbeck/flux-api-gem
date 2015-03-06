# coding: utf-8
require File.expand_path(File.join('..', 'lib', 'flux', 'version'), __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'flux-api'
  gem.version       = Flux::VERSION
  gem.authors       = ['Jami Couch']
  gem.email         = ['jami.couch@metova.com']
  gem.summary       = ''
  gem.description   = ''
  gem.homepage      = 'https://github.com/metova/flux-api-gem'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rspec', '>= 2.14.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'yarjuf'
  gem.add_development_dependency 'simplecov'

end
