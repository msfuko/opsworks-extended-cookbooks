# install scripts
template "#{node["sumoslack"][:scripts][:install_dir]}/slack.sh" do
  source "slack.sh.erb"
  owner scripts[:user]
  group scripts[:group]
  mode '755'
  variables({
                :webhook => node["sumoslack"]["webhook"],
                :alertfolder => node["sumoslack"][:scripts][:alert_dir]
            })
end