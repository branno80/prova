#Copy script start-up apache
cookbook_file "/etc/init.d/apache2" do
  source 'apache2'
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
end

#Insert Service chkconfig
execute "chkconfig command" do
command "chkconfig --add apache2" 
not_if "chkconfig --list| grep 'apache2'"
end

#Start Service Apache - Disable Apache boot time
service "apache2" do
  action [:start, :disable]
end
