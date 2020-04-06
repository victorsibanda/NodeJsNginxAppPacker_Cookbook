#
# Cookbook:: NodeJSNginx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

package 'nginx'
package 'nodejs'

service 'nginx' do
  action [:enable, :start]
end


template "/etc/nginx/sites-available/proxy.conf" do
  source 'proxy.conf.erb'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
end

link "/etc/nginx/sites-available/proxy.conf" do
  to "/etc/nginx/sites-enabled"
  link_type :symbolic
  action :create
end
