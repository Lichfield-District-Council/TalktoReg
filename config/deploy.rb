set :domain, "talktoreg.co.uk"
set :application, "talktoreg"
set :deploy_to, "/home/rails/#{application}"

set :default_environment, {
  'PATH' => "/home/rails/.rvm/gems/ruby-1.9.2-p290/bin:/home/rails/.rvm/bin:/home/rails/.rvm/rubies/ruby-1.9.2-p290/bin:$PATH",
  'RUBY_VERSION' => 'ruby-1.9.2-p290',
  'GEM_HOME' => '/home/rails/.rvm/gems/ruby-1.9.2-p290',
  'GEM_PATH' => '/home/rails/.rvm/gems/ruby-1.9.2-p290',
}

set :user, "rails"
set :use_sudo, false

# Uncomment this when I sort out a git repo
set :scm, :git
set :repository,  "git@github.com:pezholio/TalktoReg.git"
set :branch, 'master'
set :git_shallow_clone, 1

#set :repository, "."
#set :scm, :none
#set :deploy_via, :copy

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :deploy_via, :remote_cache

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  # Assumes you are using Passenger
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

    # mkdir -p is making sure that the directories are there for some SCM's that don't save empty folders
    run <<-CMD
      rm -rf #{latest_release}/log &&
      mkdir -p #{latest_release}/public &&
      mkdir -p #{latest_release}/tmp &&
      ln -s #{shared_path}/log #{latest_release}/log
    CMD

    if fetch(:normalize_asset_timestamps, true)
      stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
      asset_paths = %w(images css).map { |p| "#{latest_release}/public/#{p}" }.join(" ")
      run "find #{asset_paths} -exec touch -t #{stamp} {} ';'; true", :env => { "TZ" => "UTC" }
    end
  end
end
