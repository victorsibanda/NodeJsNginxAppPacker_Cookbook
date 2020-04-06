#
# Cookbook:: NodeJSNginx
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'NodeJSNginx::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    #let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    # installs Nginx
    it 'Should install Nginx' do
      expect(chef_run).to install_package('nginx')
    end
    # install NodeJS / Should be done from a dependency
    it 'Should install NodeJS' do
      expect(chef_run).to install_package('nodejs')
    end

    # Start and Enable Nginx
    it 'Should Enable Service Nginx' do
      expect(chef_run).to enable_service('nginx')
    end
    it 'Should Start Nginx' do
      expect(chef_run).to start_service('nginx')
    end


    it 'should create a proxy.conf template in /etc/nginx/sites-available' do
      expect(chef_run).to create_template '/etc/nginx/sites-available/proxy.conf'
    end

    it 'should symbolic link /etc/nginx/sites-available/proxy.conf to /etc/nginx/sites-enabled' do
      expect(chef_run).to create_link '/etc/nginx/sites-available/proxy.conf'
    end

    it 'should remove default link from /etc/nginx/sites-enabled/default' do
      expect(chef_run).to delete_link('/etc/nginx/sites-enabled/default')
    end


  end
end
