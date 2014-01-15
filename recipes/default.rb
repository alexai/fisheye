#
# Cookbook Name:: fisheye
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
directory "/usr/local/df" do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

remote_file "/usr/local/df/crucible-#{node['fisheye']['version']}.zip" do
	source "#{node['fisheye']['url']}/crucible-#{node['fisheye']['version']}.zip"
	owner "root"
	mode "0644"
	action :create
end

execute "install fisheye" do
	cwd "/usr/local/df"
	command "unzip crucible-#{node['fisheye']['version']}.zip;ln -s ./fecru-#{node['fisheye']['version']} fecru"
	action :run
end



