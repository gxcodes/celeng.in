require 'bundler/capistrano'
default_run_options[:pty] = true

set :application,   'celeng.in'
set :repository,    'git@github.com:gxcodes/celeng.in.git'
set :scm,           :git
set :deploy_via,    :remote_cache
set :keep_releases, 5
set :use_sudo,      false
set :ssh_options,   { forward_agent: true }
set :bundle_flags,  '--deployment --quiet --binstubs'
set :stages,        %w(production staging)

set :default_stage, 'production'
require             'capistrano/ext/multistage'

namespace :deploy do
  task :start do ; end
  task :stop do ; end

end

namespace :symlinks do
  task :database_yml, roles: :app do
    run "ln -sfn #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  task :database, roles: :app do
    run "ln -sfn #{shared_path}/celengin.sqlite3 #{release_path}/db/celengin.sqlite3"
  end

  task :uploads, roles: :app do
    run "ln -sfn #{shared_path}/uploads #{release_path}/public/uploads"
  end

  task :unicorn, roles: :app do
    run "ln -sfn #{shared_path}/config/unicorn/production.rb #{release_path}/config/unicorn/production.rb"
  end
end

namespace :db do
  desc "Create default database yml"
  task :yml, roles: :app do
    dbname     = Capistrano::CLI.ui.ask("DB Name: ")
    dbyml = <<EOF
#{rails_env}:
  adapter: sqlite3
  database: #{dbname}
  pool: 5
  timeout: 5000
EOF
    run "cd #{shared_path}; mkdir -p config"
    dbyml_name = 'database.yml'
    file = File.new(dbyml_name, "w")
    file << dbyml
    file.close
    system "rsync -vr #{dbyml_name} #{user}@#{domain}:#{shared_path}/config/#{dbyml_name}"
    File.delete(dbyml_name)
  end

end

namespace :unicorn do
  desc "Create unicorn config folder"
  task :config, roles: :app do
    run "mkdir -p #{ File.join(release_path, 'config', 'unicorn') }"
  end

  desc "Create unicorn log"
  task :log, roles: :app do
    run "touch #{ File.join(shared_path, "log", "unicorn.log") }"
  end

  desc "Create pid folder"
  task :pid_folder, roles: :app do
    run "mkdir -p #{ File.join(shared_path, 'tmp', 'pids') }"
  end
end

after   'deploy:finalize_update', 'unicorn:log', 'unicorn:config'
after   'deploy:finalize_update', 'symlinks:database_yml', 'symlinks:uploads', 'symlinks:unicorn', 'symlinks:database'
after   'deploy:update',          'deploy:migrate'
after   'deploy:create_symlink',  'unicorn:pid_folder'
after   'deploy:update',          'deploy:cleanup'
after   'deploy:restart',         'unicorn:restart'