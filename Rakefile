require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'bundler'

Bundler::GemHelper.install_tasks


desc "Run RSpec"
RSpec::Core::RakeTask.new do |t|
  t.verbose = false
  t.pattern = ['spec/**/*_spec.rb']
  t.rspec_opts = ['--options', 'spec/spec.opts']
end
# Spec::Rake::SpecTask.new(:spec) do |spec|
#   spec.ruby_opts << '-rubygems'
#   spec.libs << 'lib' << 'spec'
#   spec.spec_files = FileList['spec/**/*_spec.rb']
#   spec.spec_opts = ['--options', 'spec/spec.opts']
# end
# 
task :default => [:spec]