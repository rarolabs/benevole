set :application, 'benevole'
set :keep_releases, 5
set :rails_env, 'production'

set :scm, 'git'
set :repository, 'git@github.com:rarolabs/benevole.git'
set :branch, 'master'
set :deploy_via, :remote_cache

default_run_options[:pty]   = true
ssh_options[:forward_agent] = true

set :user, 'raro'
set :port, 22
set :use_sudo, false

set(:unicorn_env) { rails_env }

load 'deploy/assets'

# set :rvm_type, :system

server '104.131.212.9', :web, :app, :db, :primary => true

set :deploy_to, "/app/benevole/"

# runs bundle install on remote server
require "bundler/capistrano"

# if you want to clean up old releases on each deploy uncomment this:


after "deploy:restart", "deploy:cleanup"

before 'deploy:setup', 'rvm:install_rvm'
after 'deploy:restart', 'unicorn:restart'
before "deploy:assets:precompile", "deploy:migrate"

before 'deploy:finalize_update', 'deploy:assets:symlink'
after 'deploy:update_code', 'deploy:assets:precompile'

after :deploy, 'deploy:restart'
namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
      run "cd #{current_path} && touch tmp/restart.txt"
  end
  namespace :assets do
    task :precompile, :roles => :web do
      #from = source.next_revision(current_revision)
      #if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0
        run_locally("rake assets:clean && rake assets:precompile")
        run_locally "cd public && tar -jcf assets.tar.bz2 assets"
        top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
        run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
        run_locally "rm public/assets.tar.bz2"
        run_locally("rake assets:clean")
      #else
      #  logger.info "Skipping asset precompilation because there were no asset changes"
      #end
    end

    task :symlink, roles: :web do
      run ("rm -rf #{latest_release}/public/assets &&
            mkdir -p #{latest_release}/public &&
            mkdir -p #{shared_path}/assets &&
            ln -s #{shared_path}/assets #{latest_release}/public/assets")
    end
  end
end