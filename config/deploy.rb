set :application, "vinay.xp3.biz"
set :repository,  "git@github.com:vinnizworld/AI.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_via, :remote_cache

set :user, "vinay.xp3.biz"
set :use_sudo, false

role :web, "noads.biz"                          # Your HTTP server, Apache/etc
role :app, "noads.biz"                          # This may be the same as your `Web` server
role :db,  "vinay.xp3.biz", :primary => true # This is where Rails migrations will run"

set :deploy_to, "capify/"
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do
    run "/etc/init.d/apache2 start"
  end
  task :stop do
    run "/etc/init.d/apache2 stop"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :gems do
  task :install do
    run "cd #{deploy_to}/current && RAILS_ENV=production rake gems:install"
  end
end
