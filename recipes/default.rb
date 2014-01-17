#
# Cookbook Name:: fisheye
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
directory "/root/bak" do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

directory "/usr/local/df" do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

directory "/usr/local/df/fecru-data" do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

directory "/usr/local/df/fecru-data/managed-repos" do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

cookbook_file "/root/init.sql" do
   source "init.sql"
   owner  "root"
   mode   "0755"
   action :create
end

cookbook_file "/root/config.xml" do
   source "config.xml"
   owner  "root"
   mode   "0644"
   action :create
end

remote_file "/usr/local/df/crucible-#{node['fisheye']['version']}.zip" do
	source "#{node['fisheye']['url']}/crucible-#{node['fisheye']['version']}.zip"
	owner "root"
	mode "0644"
	action :create
end

remote_file "/root/mysql-connector-java-#{node['jdbc']['version']}.tar.gz" do
	source "http://cdn.mysql.com/Downloads/Connector-J/mysql-connector-java-#{node['jdbc']['version']}.tar.gz"
	owner "root"
	mode "0644"
	action :create
end

#Install Mysql-server-5.5.20
script "install_mysql" do
        interpreter "bash"
        user "root"
        cwd "/root"
        action :run
        code <<-EOH
                yum install -y mysql mysql-server
                /etc/init.d/mysqld start
                chkconfig mysqld on
                mysql -uroot < /root/init.sql
EOH
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

execute "Install JDBC" do
	cwd "/root"
	command "tar zxvf mysql-connector-java-#{node['jdbc']['version']}.tar.gz;
		cd mysql-connector-java-#{node['jdbc']['version']};
		/bin/cp -f mysql-connector-java-#{node['jdbc']['version']}-bin.jar /usr/local/df/fecru/lib/"
	action :run
end

execute "Replace config.xml in backup zip" do
	cwd "/root/bak"
	command "unzip -d /root/bak /root/#{node['fecru']['bak']['zip']};
		/bin/cp -f /root/config.xml /root/bak/config/;
		zip -r /root/#{node['bak']['finalname']} ./*"
	action :run
end	

execute "Restore fisheye" do
	cwd "/usr/local/df/fecru/bin"
	command "source /root/.bashrc;nohup /usr/local/df/fecru/bin/fisheyectl.sh restore -f /root/#{node['bak']['finalname']}"
	action :run
end

execute "Run fisheye" do
	cwd "/usr/local/df/fecru/bin"
	command "nohup /usr/local/df/fecru/bin/start.sh &"
	action :run
end
