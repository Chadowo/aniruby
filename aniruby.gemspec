
require_relative 'lib/aniruby/version'

Gem::Specification.new do |spec|
  spec.name        = 'AniRuby'
  spec.version     = AniRuby::VERSION
  spec.authors     = ['Chadow']
  spec.homepage    = 'https://github.com/Chadowo/aniruby'
  spec.summary     = 'Make sprite animations on Gosu simple and easy'
  spec.description = <<~DESC
    Library for painless sprite animations on Gosu, with a easy
    and nifty API, made in pure Ruby with no dependencies at all!
  DESC

  spec.files       = Dir.glob('lib/**/*') + %w(Rakefile)
  spec.license     = 'MIT'

  spec.require_paths = ['lib']

  spec.add_runtime_dependency('gosu', ['>= 1.4.6'])
end
