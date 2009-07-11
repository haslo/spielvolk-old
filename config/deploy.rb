set :deploy_to, "/home/user60/rails"
set :application, "spielvolk.ch"
set :user, "user60"

role :web, "user60@moria.invisible.ch"
role :app, "user60@moria.invisible.ch"
role :db,  "user60@moria.invisible.ch", :primary => true

set :use_sudo, false
set :keep_releases, 4

set :scm, :git
set :branch, "master"
set :repository, "git@github.com:haslo/spielvolk.git"
set :deploy_via, :remote_cache

namespace :deploy do
  desc "Create the database yaml file"
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end