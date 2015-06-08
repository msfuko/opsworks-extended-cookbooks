case node[:platform]
when "ubuntu","debian"
  package "docker.io" do
    action :install
  end
when 'centos','redhat','fedora','amazon'
  package "docker" do
    action :install
  end
  remote_file "/usr/bin/docker" do
	source "https://get.docker.com/builds/Linux/x86_64/docker-latest"
	mode '0777'
	notifies :run, "service[docker]", :immediately
  end
end

service "docker" do
  action :start
end
