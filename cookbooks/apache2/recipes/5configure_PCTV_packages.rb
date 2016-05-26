#Start Service Apache - Disable Apache boot time
service "apache2" do
  action [:start, :disable]
end

#Copy php5 on Apache Extra Conf Directory
cookbook_file "/product/apache2/conf/extra/php.conf" do
  source 'php'
  owner 'custapache'
  group 'apps'
  mode '0755'
  action :create_if_missing
end

#Template file httpd_vhost Apache
template "httpd-vhost" do
  path "/product/apache2/conf/extra/httpd-vhosts.conf"
  source "httpd-vhosts.conf.erb"
notifies :restart, "service[apache2]"
end

#Template file httpd.conf Apache
template "httpd-conf" do
  path "/product/apache2/conf/httpd.conf"
  source "httpd.conf.erb"
notifies :restart, "service[apache2]"
end

#Upload PCTV Site DOC_ROOT
execute 'extract_tar_PCTV' do
  command 'tar xvf /opt/avs42hyderabad_web_site.tar'
  cwd '/product/apache2/'
  not_if "test -d /product/apache2/avs42hyderabad"
end

#Permission on DOC_ROOT
execute 'permission on doc_root' do
  command 'chmod -R 755 /product/apache2/avs42hyderabad'
  not_if "test -d /product/apache2/avs42hyderabad"
end
