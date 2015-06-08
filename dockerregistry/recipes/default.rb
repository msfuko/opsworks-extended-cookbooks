node[:deploy].each do |application, deploy|

# install scripts
  template "#{deploy[:deploy_to]}/current/cmd/registry/config.yml" do
    source "config.yml.erb"
    user deploy[:user]
    group deploy[:group]
    mode '755'
    variables({
                :region => node["dockerregistry"]["region"],
                :bucket => node["dockerregistry"]["bucket"]
            })
	end
end
