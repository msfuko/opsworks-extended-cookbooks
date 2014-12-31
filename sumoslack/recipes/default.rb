scripts = node["sumoslack"][:scripts]

# install scripts
template "#{scripts[:install_dir]}/slack.sh" do
  source "slack.sh.erb"
  owner scripts[:user]
  group scripts[:group]
  mode '755'
  variables({
                :webhook => node["sumoslack"]["webhook"],
                :alertfolder => scripts[:alert_dir]
            })
end