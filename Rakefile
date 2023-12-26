require 'bundler/gem_tasks'
require 'minitest/test_task'

require_relative 'lib/aniruby/version'

Minitest::TestTask.create

task :default => :test

desc 'Use YARD to generate documentation'
task :doc do
  sh 'yardoc'
end
