require 'rake'
require 'rspec/core/rake_task'
require "bundler/gem_tasks"

task :default => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
  t.rspec_opts = "--color"
end

