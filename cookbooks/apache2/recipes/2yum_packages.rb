#Install Require Packages RPM in order to compile APACHE2.2.31

%w{glibc libcurl-devel libaio-devel unixODBC-devel libaio libtool-ltdl libtool-ltdl-devel unixODBC sysstat make apr-util apr-util-devel libxml2-devel openssl-devel}.each do |pkg|
        package pkg do
      action :install
   end
end
