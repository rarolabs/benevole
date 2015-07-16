set :application, "benevole"
set :repository,  "git@github.com:rarolabs/benevole.git"
set :scm, :git
set :stages, %w(production)
set :default_stage, "production"

require 'bundler/capistrano'

require "rvm/capistrano"
require 'capistrano-unicorn'

set :default_environment, {
  'BUNDLE_PATH'  => '/home/raro/.rvm/gems/ruby-2.1.1@global/bin/bundle',
  'PATH' => "/home/raro/.rvm/gems/ruby-2.1.1/bin:/home/raro/.rvm/gems/ruby-2.1.1@global/bin:/home/raro/.rvm/rubies/ruby-2.1.1/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/raro/.rvm/bin:/home/raro/bin",
  'RUBY_VERSION' => "2.1.1p76",
  'GEM_HOME' =>"/home/raro/.rvm/gems/ruby-2.1.1",
  'GEM_PATH' => "/home/raro/.rvm/gems/ruby-2.1.1:/home/raro/.rvm/gems/ruby-2.1.1@global",
  'LANG' => 'en_US.UTF-8'
}

set :rvm_ruby_string, "ruby-2.1.1"              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"

require 'capistrano/ext/multistage'