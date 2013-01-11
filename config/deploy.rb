set :application, "bytesynth"
set :repository,  "https://github.com/mmcdaris/bytesynth.git"

set :deploy_to, "/webapps/"
set :scm, :git

set :deploy_via, :copy
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :location, "174.129.110.112" 

role :web, location                          # Your HTTP server, Apache/etc
role :app, location                          # This may be the same as your `Web` server
role :db,  location, :primary => true        # This is where Rails migrations will run

set :use_sudo, true
set :user, "ubuntu"
ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "gsg-keypair")]
ssh_options[:forward_agent] = true  

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
