#Compile Software
version = "2.2.31"
bash "install_apache_from_source" do 
user "root"
cwd "/tmp" 
code <<-EOH
cd /product/software
tar zxf "httpd-2.2.31.tar.gz" 
cd "httpd-2.2.31"
./configure --prefix=/product/apache2 --enable-auth-digest --enable-proxy --enable-proxy-ajp --enable-proxy-connect --enable-proxy-ftp --enable-proxy-http --enable-rewrite --enable-so --enable-deflate --with-mpm=prefork --enable-headers --enable-ssl && make && make install
cd /product/software/httpd-2.2.31/modules/metadata
/product/apache2/bin/apxs -i -a -c mod_headers.c
cp /product/software/php-5.6.2/libs/libphp5.so /product/apache2/modules/
chown -R custapache:apps /product/apache2
EOH
not_if "test -f /product/apache2/bin/apachectl"
end

#Execute Sed Command on Httpd.conf
execute "sed command" do
command "sed -i 's|LoadModule headers_module     modules/mod_headers.so|#LoadModule headers_module     modules/mod_headers.so|g' /product/apache2/conf/httpd.conf"
not_if "cat /product/apache2/conf/httpd.conf | grep -i modules/mod_headers.so | grep '#'"
end
