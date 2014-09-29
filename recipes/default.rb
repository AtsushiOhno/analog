#
# Cookbook Name:: analog
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
if node['platform'] == "ubuntu" && node['platform_version'].to_f <= 10.04
  package "git-core"
else
  package "git"
end

case node[:platform]
when "centos"
  platform_version = node[:platform_version].to_f

  if platform_version >= 6.0 then
    rpmfile = "analog-6.0.4-1.x86_64.rpm"
  elsif platform_version >= 5.0 then
    rpmfile = "analog-6.0.4-1.el5.i386.rpm"
  else
    raise "This recipe can't be applied to thisd environment!"
  end
  
  remote_file "#{Chef::Config[:file_cache_path]}/#{rpmfile}" do
    source "http://www.iddl.vt.edu/~jackie/analog/#{rpmfile}"
  end
  
  package "analog" do
    action :install
    source "#{Chef::Config[:file_cache_path]}/#{rpmfile}"
    provider Chef::Provider::Package::Rpm
  end
end
