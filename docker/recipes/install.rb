case node[:platform]
when "ubuntu","debian"
  package "docker.io" do
    action :install
  end
when 'centos','redhat','fedora','amazon'
  package "docker" do
    action :install
  end
  #bash "upgrate_docker" do
	#user "root"
	#code <<-EOH
	#	mv /usr/bin/docker /usr/bin/docker-old
	#	wget https://get.docker.com/builds/Linux/x86_64/docker-latest -O /usr/bin/docker
	#	chmod 777 /usr/bin/docker
	#EOH
  #end
end

service "docker" do
  action :start
end
