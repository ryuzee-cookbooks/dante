#
# Cookbook Name:: dante
# Recipe:: default
#
# Copyright 2014, Ryutaro YOSHIBA
#
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

include_recipe 'build-essential'

user 'sockd' do
  comment 'User for sockd'
  system true
  shell '/bin/false'
end

remote_file "#{Chef::Config[:file_cache_path]}/dante-#{node["dante"]["version"]}.tar.gz" do
  source "http://www.inet.no/dante/files/dante-#{node["dante"]["version"]}.tar.gz"
  mode 0644
  checksum "#{node['dante']['checksum']}"
end

%w(pam-devel).each do |package_name|
  package package_name do
    action :install
  end
end

execute "rpmbuild -ta #{Chef::Config[:file_cache_path]}/dante-#{node['dante']['version']}.tar.gz" do
  action :run
end

arch = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i386'

package_names = [
  "dante-#{node['dante']['version']}-1.el6.#{arch}.rpm",
  "dante-server-#{node['dante']['version']}-1.el6.#{arch}.rpm",
  "dante-debuginfo-#{node['dante']['version']}-1.el6.#{arch}.rpm",
  "dante-devel-#{node['dante']['version']}-1.el6.#{arch}.rpm"
]

package_names.each do |package_name|
  package package_name do
    action :upgrade
    source "/root/rpmbuild/RPMS/#{arch}/#{package_name}"
    provider Chef::Provider::Package::Rpm
  end
end

template '/etc/sockd.conf' do
  source 'sockd.conf.erb'
  owner 'root'
  group 'root'
  mode '00644'
  notifies :restart, 'service[sockd]'
end

template '/etc/socks.conf' do
  source 'socks.conf.erb'
  owner 'root'
  group 'root'
  mode '00644'
  notifies :restart, 'service[sockd]'
end

service 'sockd' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
