#
# Cookbook Name:: quoteapp
# Recipe:: default
#
# Copyright 2015, Compara Online S.A.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'quoteapp::nodejs'

group node['quoteapp']['group']

user node['quoteapp']['user'] do
  action :create
  comment 'User for running node programs'
  gid node['quoteapp']['group']
  supports :manage_home => false
end

if node['quoteapp']['create_install_dir']
  directory node['quoteapp']['install_dir'] do
    owner node['quoteapp']['user']
    group node['quoteapp']['group']
    mode '0775'
    action :create
  end
end

template "/etc/init/quoteapp.conf" do
  source "quoteapp.conf.erb"
  mode '0644'
  action :create
end

execute 'npm install' do
  cwd node['quoteapp']['install_dir']
  user node['quoteapp']['user']
  group node['quoteapp']['group']
  environment ({'HOME' => '/home/vagrant'})
end
