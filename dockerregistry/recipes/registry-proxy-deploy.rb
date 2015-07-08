include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  
  if node[:opsworks][:instance][:layers].first != deploy[:environment_variables][:layer]
    Chef::Log.debug("Skipping deploy::docker application #{application} as it is not deployed to this layer")
    next
  end

  # cert
  file "#{deploy[:deploy_to]}/current/certs/docker-registry.crt" do
    owner deploy[:user]
    mode 0600
    content deploy[:ssl_certificate]
    only_if do
      deploy[:ssl_support]
    end
  end

  file "#{deploy[:deploy_to]}/current/certs/docker-registry.key" do
    owner deploy[:user]
    mode 0600
    content deploy[:ssl_certificate_key]
    only_if do
      deploy[:ssl_support]
    end
  end
	
  # deploy proxy
  bash "docker-proxy-run" do
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
      docker run -d -p 443:443 -e REGISTRY_HOST=#{deploy[:application]} -e REGISTRY_PORT=#{deploy[:environment_variables][:service_port]} -e SERVER_NAME="localhost" --link #{deploy[:application]}:#{deploy[:application]} -v /root/docker-registry.htpasswd:/etc/nginx/.htpasswd:ro -v #{deploy[:deploy_to]}/current/certs:/etc/nginx/ssl:ro containersol/docker-registry-proxy
    -v $(pwd)/.htpasswd
    EOH
  end

end
