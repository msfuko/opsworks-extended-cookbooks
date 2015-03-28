include_recipe 'python'
include_recipe "python::pip"

scripts = node["omniitest"][:scripts]

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
  guard_interpreter :python
  code "nosetests #{scripts[:install_dir]}/omniitest.py"
end


