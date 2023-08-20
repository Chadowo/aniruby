
require 'fileutils'
require "minitest/test_task"

require_relative 'lib/aniruby/version'

Minitest::TestTask.create

task :default => :build

desc 'Build the gem'
task :build do
  Dir.mkdir('pkg') unless Dir.exist?('pkg')

  sh 'gem build aniruby.gemspec'

  FileUtils.mv("AniRuby-#{AniRuby::VERSION}.gem", 'pkg')
end

desc 'Clean the build enviroment'
task :clean do

  FileUtils.rm_rf('pkg')
end

desc 'Use YARD to generate documentation'
task :doc do
  sh 'yardoc'
end
