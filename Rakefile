
require 'fileutils'

require_relative 'lib/aniruby/version'

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
