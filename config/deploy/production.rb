set :user,        "akademirails"
set :app_name,    "celeng.in"
set :deploy_to,   "/home/#{user}/#{app_name}"
set :default_environment, {
  'PATH' => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH"
}

set :unicorn_bundle, "bin/bundle"
set :unicorn_pid,    "/home/#{user}/#{app_name}/shared/tmp/pids/unicorn.pid"
require "capistrano-unicorn"

set :domain,      "celengin.kurniaone.com"
set :branch,      "master"
set :rails_env,   "production"
set :unicorn_env, "production"
set :app_env,     "production"

set :migrate_target, :latest
role :web,  domain
role :app,  domain
role :db,   domain, primary: true
