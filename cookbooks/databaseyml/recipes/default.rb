require 'pp'
#
# Cookbook Name:: databaseyml
# Recipe:: default
#

node[:applications].each do |app_name,data|
  user = node[:users].first
  db_name = "#{app_name}_#{node[:environment][:framework_env]}"
  
  template "/data/#{app_name}/shared/config/database.yml" do
    source "database.yml.erb"
    owner user[:username]
    group user[:username]
    mode 0744
    variables({
        :app_name => app_name,
        :db_pass => user[:password]
    })
  end
end
