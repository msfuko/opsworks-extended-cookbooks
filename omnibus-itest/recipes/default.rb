include_recipe 'python'
include_recipe "python::pip"

scripts = node["omniitest"][:scripts]

# create directory
directory "#{scripts[:install_dir]}" do
  owner scripts[:user]
  group scripts[:group]
  recursive true
end

# install scripts
template "#{scripts[:install_dir]}/omniitest.py" do
  source "omniitest.py.erb"
  owner scripts[:user]
  group scripts[:group]
  mode '755'
  variables({
                :url => node["omniitest"]["url"],
                :username => node["omniitest"]["username"],
                :password => node["omniitest"]["password"]
            })
end

# install nose
python_pip "nose" do
  version "1.3.4"
end

# run scripts
python "itest" do
  code "nosetests #{scripts[:install_dir]}/omniitest.py"
end


