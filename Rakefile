
require 'fileutils'
require 'minitest/test_task'

require_relative 'lib/aniruby/version'

Minitest::TestTask.create

task :default => :test

desc 'Build the gem'
task :build do
  Dir.mkdir('pkg') unless Dir.exist?('pkg')

  sh 'gem build aniruby.gemspec'

  FileUtils.mv("aniruby-#{AniRuby::VERSION}.gem", 'pkg')
end

desc 'Clean the build enviroment'
task :clean do
  FileUtils.rm_rf('pkg')
end

desc 'Push the gem to RubyGems'
task :push do
  sh "gem push pkg/aniruby-#{AniRuby::VERSION}.gem"
end

desc 'Use YARD to generate documentation'
task :doc do
  sh 'yardoc'
end
