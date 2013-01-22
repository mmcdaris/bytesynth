# Load RVM's capistrano plugin.
require "rvm/capistrano"
require 'bundler/capistrano'

set :rvm_path, "$HOME/.rvm"
set :rvm_ruby_string, 'ruby-1.9.2-head' 
set :rvm_type, :user  # Don't use system-wide RVM

set :application, "bytesynth"
set :repository,  "https://github.com/mmcdaris/bytesynth.git"

set :deploy_to, "/home/ubuntu/"
set :scm, :git

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :location, "184.72.189.151" 

role :web, location                          # Your HTTP server, Apache/etc
role :app, location                          # This may be the same as your `Web` server
role :db,  location, :primary => true        # This is where Rails migrations will run

ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "gsg-keypair")]
ssh_options[:forward_agent] = true  
set :use_sudo, false
set :deploy_to, "/home/ubuntu/"
set :user, "ubuntu"

namespace :deploy do
    task :start do ; end
    task :stop do ; end
    task :restart, :roles => :app, :except => { :no_release => true } do
       run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    end
end

# fix missing assets  error
load 'deploy/assets'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
