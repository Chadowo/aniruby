
require_relative 'lib/aniruby/version'

Gem::Specification.new do |spec|
  spec.name        = 'aniruby'
  spec.version     = AniRuby::VERSION
  spec.date        = Time.now.strftime "%Y-%m-%d"
  spec.authors     = ['Chadow']
  spec.homepage    = 'https://github.com/Chadowo/aniruby'

  spec.summary     = 'Make sprite animations on Gosu simple and easy'
  spec.description = <<~DESC
    Library for painless sprite animations on Gosu, with a easy
    and nifty API, made in pure Ruby with no dependencies at all!
  DESC

  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.files       = Dir.glob('lib/**/*') + %w(Rakefile)
  spec.files       += %w(README.md CHANGELOG.md LICENSE .yardopts)
  spec.license     = 'MIT'

  spec.require_paths = ['lib']

  spec.add_runtime_dependency('gosu', ['>= 1.4.6'])
  spec.add_development_dependency('minitest', ['~> 5.17.0'])
end
