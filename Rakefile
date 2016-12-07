require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

begin
    require 'puppet_blacksmith/rake_tasks'
rescue
end

exclude_paths = [
  "pkg/**/*",
  ".vendor/**/*",
  "spec/**/*",
  "vendor/**/*",
]

PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths


desc "Run syntax, lint and spec tests."
task :test => [
  :syntax,
  :spec,
  :lint,
]
