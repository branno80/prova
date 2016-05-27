#Create Group Apps
group "apps" do
   gid 10000
end

# Create custapache User..the password require ruby-shadow package
user 'custapache' do
  action :create
  uid 1004
  comment 'WebServer User'
  gid "apps"
  home '/home/custapache'
  shell '/bin/bash'
  password "$1$54ZC/A1k$Cb2JiCF2eQgCtbXRwOLw0."
end


#Create Directory Apache Software
directory '/product/apache2' do
  owner 'custapache'
  group 'apps'
  mode '0755'
  action :create
end
