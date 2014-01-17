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

execute "Download backup zip" do 
	cwd "/root"
	command "wget #{node['fecru']['bak']['path']}/#{node['fecru']['bak']['zip']}"
	action :run
end

execute "install fisheye" do
	cwd "/usr/local/df"
	command "unzip crucible-#{node['fisheye']['version']}.zip;ln -s ./fecru-#{node['fisheye']['version']} fecru"
	action :run
end

execute "Restore fisheye" do
	cwd "/usr/local/df/fecru/bin"
	command "nohup ./fisheyectl.sh restore -f /root/#{node['fecru']['bak']['zip']}"
	action :run
end

execute "Run fisheye" do
	cwd "/usr/local/df/fecru/bin"
	command "nohup ./start.sh"
	action :run
end
