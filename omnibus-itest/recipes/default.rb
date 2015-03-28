include_recipe 'python'

scripts = node["omniitest"][:scripts]

# install scripts
template "#{scripts[:install_dir]}/omniitest.py" do
  source "omniitest.py.erb"
  owner scripts[:user]
  group scripts[:group]
  mode '755'
end

# install nose
python_pip "nose" do
  version "1.3.4"
end

# run scripts
python "itest" do
  guard_interpreter :python
  environment {	"OMNIBUS_URL" => node["omniitest"]["url"] }
  code "nosetests #{scripts[:install_dir]}/omniitest.py"
end


