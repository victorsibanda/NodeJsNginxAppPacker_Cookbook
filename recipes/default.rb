#
# Cookbook:: NodeJSNginx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

include_recipe 'apt'
include_recipe 'nodejs'


apt_update 'update_sources' do
  action :update
end

package 'nginx'
#package 'nodejs'
#package "curl"


service 'nginx' do
  action [:enable, :start]
end

#nodejs_npm 'pm2'

npm 'pm2'

nodejs_npm 'react'



template "/etc/nginx/sites-available/proxy.conf" do
  source 'proxy.conf.erb'
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end

link "/etc/nginx/sites-available/proxy.conf" do
  to "/etc/nginx/sites-enabled/proxy.conf"
  link_type :symbolic
  action :create
  notifies :restart, 'service[nginx]'
end
