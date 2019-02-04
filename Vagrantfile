$TOMCAT_COUNT = 2

Vagrant.configure("2") do |config|
	config.vm.box = "bento/centos-7.5"
	config.vm.box_check_update=false
	config.vm.provider "virtualbox" do |vb|
		vb.gui = false
		vb.memory = 256
		vb.cpus = 2
		vb.check_guest_additions=false
	end

  config.vm.define "frontserver1" do |server1|
  	server1.vm.hostname = "frontserver1"
  	server1.vm.network "private_network", ip: "192.168.0.10"
    server1.vm.network "forwarded_port", guest: 80, host: 8400
  	server1.vm.provision "shell", inline: <<-SHELL
      yum install httpd -y -q
			cp -f /vagrant/mod_jk.so /etc/httpd/modules/
			chmod 755 /etc/httpd/modules/mod_jk.so
			cp -f /vagrant/httpd_mod_jk.conf /etc/httpd/conf.d/
			cp -f /vagrant/workers.properties /etc/httpd/conf/
			firewall-cmd --zone=public --add-port=80/tcp --permanent
			firewall-cmd --reload
			systemctl stop firewalld
			systemctl enable httpd
      systemctl stop httpd
			systemctl start httpd
  	SHELL
  end

	(1..$TOMCAT_COUNT).each do |i|
	    config.vm.define "inserver#{i}" do |node|
					node.vm.hostname = "inserver#{i}"
	        node.vm.network "private_network", ip: "192.168.0.#{10+i}"
					node.vm.provision "shell", inline: <<-SHELL
						yum install java-1.8.0-openjdk -y -q
						yum install tomcat tomcat-webapps tomcat-admin-webapps -y -q
						mkdir /usr/share/tomcat/webapps/app1/
						echo "Tomcat server#{i}" > /usr/share/tomcat/webapps/app1/index.html
						systemctl enable tomcat
						systemctl start tomcat
					SHELL
	    end
	end

config.vm.provision "shell", inline: <<-SHELL
	grep -q '192.168.0.[10-12]' '/etc/hosts' && echo "++++ hosts file is good" || echo "192.168.0.10 frontserver1\n192.168.0.11 inserver1\n192.168.0.12 inserver2\n" >> /etc/hosts;
SHELL

end
