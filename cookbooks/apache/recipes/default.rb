#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "httpd" do
	action :install
end

node["apache"]["sites"].each do |sitename, data|
	document_dir = "/content/sites/#{sitename}"
	
	directory document_dir do
		recursive true
		mode "0755"
	end

	template "/etc/httpd/conf.d/#{sitename}.conf" do
		source "vhost.erb"
		mode "0644"
		variables(
			:document_root => document_dir,
			:port => data["port"],
			:domain => data["domain"]
		)
		notifies :restart, "service[httpd]"
	end
end

execute "rm /etc/httpd/conf.d/welcome.conf" do
	only_if do
		File.exist?("/etc/httpd/conf.d/welcome.conf")
	end
end

execute "rm /etc/httpd/conf.d/README" do
	only_if do
		File.exist?("/etc/httpd/conf.d/README")
	end
end


service "httpd" do
	action [:enable, :start]
end

include_recipe("php::default")
