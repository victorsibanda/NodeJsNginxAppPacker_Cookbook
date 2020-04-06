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

service 'nodejs' do
  action [:enable, :start]
end
