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
#package 'npm'

npm_package 'pm2'
npm_package 'react'

#service 'nginx' do
#  action [:enable, :start]
#end

template "/etc/nginx/sites-available/proxy.conf" do
  source 'proxy.conf.erb'
  variables( proxy_port: node['nginx']['proxy_port'])
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end

link "/etc/nginx/sites-enabled/proxy.conf" do
  to "/etc/nginx/sites-available/proxy.conf"
  link_type :symbolic
  action :create
  notifies :restart, 'service[nginx]'
end

service 'nginx' do
  action [:enable, :start]
end
