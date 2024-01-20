require_relative 'lib/aniruby/version'

Gem::Specification.new do |spec|
  spec.name     = 'aniruby'
  spec.version  = AniRuby::VERSION
  spec.authors  = ['Chadow']
  spec.homepage = 'https://github.com/Chadowo/aniruby'

  spec.summary     = 'Create sprite animations on Gosu, simply and easily'
  spec.description = <<~DESC
    Library for painless sprite animations on Gosu, with an easy
    and nifty API, made in pure Ruby with no dependencies at all!
  DESC

  spec.required_ruby_version = '>= 2.5.0'

  spec.requirements << 'Gosu installed and working'

  spec.files = Dir.glob('lib/**/*')
  spec.files += %w[README.md CHANGELOG.md LICENSE Rakefile .yardopts]
  spec.license = 'MIT'

  spec.require_paths = ['lib']

  spec.add_runtime_dependency('gosu', ['>= 1.4.6'])

  spec.add_development_dependency('minitest', ['~> 5.17.0'])
  spec.add_development_dependency('minitest-reporters', ['~> 1.6.0'])
  spec.add_development_dependency('rake', ['~> 13.0.0'])

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/Chadowo/aniruby/issues',
    'changelog_uri' => 'https://github.com/Chadowo/aniruby/blob/main/CHANGELOG.md',
    'homepage_uri' => spec.homepage,
    'source_code_uri' => 'https://github.com/Chadowo/aniruby'
  }
end
